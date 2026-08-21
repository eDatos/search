# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`search` (a.k.a. *buscador*) is the ISTAC / eDatos public search front-end: a Spring MVC + JSP web app that queries a Solr index built elsewhere. It is a **read-only consumer** of the index — nothing here indexes documents.

Legacy naming is everywhere and does not match the repo name. Expect all three in the same file:
- Maven artifacts: `search-parent`, `search-core`, `search-web`
- Java packages: `es.gobcan.istac.idxmanager.*`
- WAR `finalName` is `buscador`, but the Dockerfile copies it in as `search.war` (context path `/search`)

Code, comments and identifiers are in Spanish (`Busqueda`, `Auditoria`, `ServiceExcepcion`, `pestania`, `filtroTexto`).

## Build & run

```bash
mvn clean install
```

```bash
mvn clean package && docker build -f dockerfiles/Dockerfile -t search:dev . && docker run -i --rm -p 8080:8080 search:dev
```

There are **no tests in this repository** — no `src/test` in any module. `mvn test` is a no-op; don't report it as verification. If you add tests, `search-web` already has JUnit 4.7 on the test classpath; `search-parent` manages `solr-test-framework`.

Java 8, Spring 3.1.1, Servlet 2.5, Tomcat 9 / JDK 8. Do not introduce APIs newer than Java 8 or Spring annotations from later versions.

`maven-enforcer-plugin` fails the build on version divergence within `org.siemac.metamac` and `com.arte.libs` — bumping one of those usually means bumping siblings in `search-parent/pom.xml`.

## The domain model is not in this repo

`es.gobcan.istac.idxmanager.domain.*` — `Busqueda` (the MVC form-backing bean), `IndexacionEnumDomain` (every Solr field name), `TypeNMDomain`, `FiltroTextoEnum`, `FiltroSeccionEnum` — comes from the external `search-indexer-domain` artifact (`${search-indexer.version}` in `search-parent/pom.xml`). Adding a search field or filter parameter usually means releasing `search-indexer` first, then bumping the version here. Never hardcode a Solr field name; go through `IndexacionEnumDomain`.

## Configuration comes from the database, not from files

`application.properties` holds only `app.version`. Real configuration is metamac's `ConfigurationService`, which reads `tb_data_configurations` in the **common-metadata** schema. The `environment.xml` bootstrap file is located via the `SEARCHCONF_PATH` env var (falls back to `classpath:metamac/environment.xml`).

Keys used by this app (`Constantes.java`):
- `istac.idxmanager.solr.endpoint`, `.core_or_collection`, `.cloud_server_enabled`
- `search.data.path` — root dir for CSV audit files
- `search.web.api_key`
- `search.audit.file.enabled`, `search.audit.kafka.enabled` — **absent property means enabled**; the `catch (MetamacException) → return true` pattern is deliberate

Adding or removing a config key requires an SQL script under `etc/changes-from-release/<previous-version>/db/common-metadata/postgresql/` **and** an entry in `UPGRADE.md`. That is how operators know an upgrade needs more than swapping the WAR.

## Architecture

**Request path.** `urlrewrite.xml` forwards everything except `/images`, `/scripts`, `/theme` to `/app/*`, which is the DispatcherServlet mapping. Filters run in `web.xml` order: `EncodingFilter` (UTF-8) → `XSSFilter` (security headers + `XSSRequestWrapper` parameter scrubbing) → `UrlRewriteFilter`.

**Two Spring contexts.** Root context = `WEB-INF/config/spring/applicationContext.xml`, which wires metamac's `ConfigurationServicePropertyPlaceholderConfigurer`, the i18n `messageSource`, and imports `classpath:/spring/include/applicationContext.xml` from `search-core` (component-scan of `...idxmanager.core`, the `solr` bean, `configurationService`). Servlet context = `mvc-config.xml` (component-scan of `...idxmanager.web.buscador`, JSP view resolver at `/WEB-INF/jsp/vistas/`, cookie-based locale).

`search-core/src/main/resources/spring/include/idxmanager-services-beans.xml` is dead — nothing imports it, and it duplicates the `solr` bean. Edit `applicationContext.xml` in the same directory instead.

**Search flow.** `BusquedaController.read` → `BusquedaService.ejecutarQuery` → `SolrService.ejecutarQuery`. Two Solr requests per search: the main query, then `ejecutarQueryForSuggested` against the `/sponsored` handler. `BusquedaServiceImpl.processOptions` picks the Solr request handler: `/browse` for a plain user query, `/select` when `searchType` is set (advanced search, where the query string is assembled by hand and escaped with `ClientUtils.escapeQueryChars`). Every query appends a `-nm_last_version:false` filter so superseded resource versions are hidden while crawled web documents (which lack the field) still match.

Controller responses are sanitised with jsoup before reaching the JSP: highlighting on `tk_contenido` and `nm_description` are whitelisted down to `NOT_CLEAN_TAGS`.

**Facets.** `FiltrosComponent` caches the subject-area and statistical-operation dropdowns from an empty facet query, refreshed lazily after 5 minutes. Composite facet values are `key#value` strings split by `getFacetKeyValue`.

**Auditing.** `BusquedaServiceImpl` autowires `List<AuditoriaService>` and calls **every** implementation on each search — currently `AuditoriaServiceImpl` (monthly CSV under `search.data.path/auditoria/YYYYMM.csv`) and `AuditoriaKafkaServiceImpl` (JSON to the `SEARCH_AUDIT_QUERIES` topic). This is a deliberate transitional dual-write; adding a `@Service` implementing `AuditoriaService` silently enrols it. `KafkaInitializeTopics` creates the topic on root-context refresh. Audit failures are always swallowed and logged — a search must never fail because auditing did.

## Conventions worth matching

- Services throw `ServiceExcepcion` with a `ServiceExcepcionTipo`; the web layer catches broadly and rejects a field on the `BindingResult` rather than propagating.
- `SolrServiceImpl` is XML-configured with setters (not `@Service`) because its properties are placeholder-resolved; the rest of `core` is component-scanned.
- Logging is `org.apache.commons.logging` in most classes, routed to SLF4J/logback. Match the surrounding file rather than standardising.
- Releases are cut with `maven-release-plugin` (`search-perform-release` profile skips surefire); the `develop` → `master` merge and `[maven-release-plugin]` commits are automated — don't hand-edit versions in poms.

# Workflow

## Fase 0 - Inicialización

Al comenzar cualquier conversación:

1. Leer `PROJECT_CONTEXT.md`.
2. Buscar la carpeta `specs/`.
3. Identificar si la petición corresponde a:

   * una nueva funcionalidad,
   * una mejora,
   * una corrección,
   * una refactorización,
   * una revisión.

No escribir código durante esta fase.

---

## Fase 1 - Discovery

Si se trata de una nueva funcionalidad o de un cambio importante:

1. Crear una nueva especificación utilizando la plantilla.
2. Inspeccionar el repositorio.
3. Identificar implementaciones similares.
4. Detectar:

   * plugins implicados,
   * actions,
   * auth,
   * blueprints,
   * templates,
   * helpers,
   * validators,
   * modelos,
   * migraciones.

Después comenzar una entrevista técnica.

Las preguntas deben hacerse una por una.

Cada pregunta debe depender de la respuesta anterior.

No formular preguntas cuya respuesta pueda obtenerse leyendo el repositorio.

---

## Fase 2 - Comprensión

Cuando exista suficiente contexto:

Generar un resumen con:

* Problema.
* Objetivo.
* Restricciones.
* Riesgos.
* Componentes afectados.
* Suposiciones.
* Información pendiente.

Preguntar si el resumen es correcto.

No continuar hasta recibir confirmación.

---

## Fase 3 - Diseño

Proponer una o varias soluciones.

Para cada solución indicar:

* ventajas,
* inconvenientes,
* impacto,
* complejidad,
* riesgos.

Recomendar una.

Esperar aprobación.

No escribir código.

---

## Fase 4 - Implementación

Solo comenzar cuando el usuario lo indique explícitamente.

Antes de modificar archivos:

* explicar el plan,
* indicar qué archivos se modificarán,
* justificar cada cambio.

Durante la implementación:

* respetar la arquitectura existente,
* evitar duplicidades,
* reutilizar componentes,
* seguir las convenciones del proyecto.

---

## Fase 5 - Revisión

Una vez terminada la implementación:

Revisar:

* calidad del código,
* compatibilidad,
* seguridad,
* rendimiento,
* mantenibilidad,
* deuda técnica.

Proponer mejoras si existen.

---

# Reglas generales

Nunca asumir información que pueda verificarse.

Siempre inspeccionar primero el código existente.

Si existe una implementación similar, reutilizar su patrón.

Preguntar únicamente aquello que no pueda deducirse del repositorio.

No generar código hasta completar Discovery y Diseño.

Priorizar mantener la coherencia del proyecto frente a introducir soluciones nuevas.

Si detectas que el usuario intenta saltarse el flujo, recuérdale en qué fase se encuentra la tarea y confirma que desea continuar.

El objetivo principal no es escribir código rápidamente, sino comprender correctamente el problema y producir una solución consistente con la arquitectura del proyecto.

## Persistent Project Knowledge

### Purpose

Maintain long-term project knowledge to improve continuity across development sessions and enable both humans and AI agents to understand the project's evolution.

After completing any significant task, evaluate whether the work introduces knowledge that should persist beyond the current conversation. If it does, update the appropriate document inside the `docs/` directory before finishing.

### What to Document

Only document information that is expected to remain valuable for future development, such as:

- Architectural decisions and their rationale.
- Design decisions and trade-offs.
- Project conventions or coding standards.
- Adopted patterns or anti-patterns.
- New dependencies and why they were introduced.
- Significant changes to the project structure.
- Reusable implementation strategies.
- Environment or configuration requirements.
- Known limitations or technical debt.
- Problems encountered and how they were resolved.
- Lessons learned that could prevent future mistakes.
- Any project-specific knowledge that would help future contributors or AI agents work more effectively.

### Documentation Guidelines

Documentation should be:

- Incremental rather than rewritten from scratch.
- Concise and focused.
- Organized by topic within the `docs/` directory.
- Easy to scan and maintain.
- Consistent with existing documentation.

Create new documents only when an appropriate one does not already exist.

### What Not to Document

Do **not** document:

- Trivial code changes.
- Temporary implementation details.
- Information already documented elsewhere.
- Experimental work that was discarded.
- Self-evident code behavior.
- Session-specific conversation history.

### Decision Rule

Before completing any task, ask yourself:

> "Will this information still be useful to a developer or AI agent in three months?"

If the answer is **yes**, persist it in the appropriate document under `docs/`.

If the answer is **no**, do not create or update documentation.

### Documentation Priority

Prefer updating existing documentation over creating new files.

When creating new documentation, choose descriptive filenames and place them in the most appropriate location within the `docs/` hierarchy.

Documentation should represent enduring project knowledge, not a changelog.

## Mensajes de commit

Estructura obligatoria: una línea de asunto, línea en blanco y una lista de viñetas con un cambio por línea.

```
CODIGO_TAREA: (TIPO_DE_CAMBIO) - Breve descripción del cambio

- Cambio 1
- Cambio 2
- ...
```

- **`CODIGO_TAREA`**: identificador de la tarea en el gestor (`ISTACID-91`), el mismo que da nombre a la rama.
- **`TIPO_DE_CAMBIO`**: entre paréntesis y en minúsculas — `feat` (funcionalidad nueva), `fix` (corrección), `ref` (refactor o ajuste sin cambio funcional), `doc`, `test`, `chore` (dependencias, scripts, infraestructura).
- **Breve descripción**: una sola línea en español que resume el commit completo, sin punto final.
- **Viñetas**: una por cambio (agrupando por área, no un fichero por línea), redactadas en pasiva refleja («Se añade…», «Se unifica…»), explicando el qué y el por qué, con ficheros y símbolos entre backticks. Sin punto final.

Ejemplo:

```
ISTACID-91: (feat) - Se añade la página de variaciones del IPC y la API REST v1

- Se crea la página `/variaciones` con el formulario de periodo inicial y final, su callback y el enlace en la navegación del shell eDatos
- Se expone la API REST v1 (`GET /api/v1/ipc/variation` y `GET /api/v1/ipc/metadata`) con validación de parámetros en castellano, CORS y cabeceras de caché
- Se presenta y aplica la tasa con 1 decimal en `ipc_service`, conservando el valor sin redondear en `variation_pct_raw`, para replicar al calculador oficial del INE
```