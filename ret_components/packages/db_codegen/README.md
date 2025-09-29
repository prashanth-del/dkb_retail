# db_codegen

A tiny toolkit for Flutter apps:
- **`schemacast`** → JSON → Freezed DTO + Entity generator
- **`seed`** → Feature folder skeleton generator (Clean Architecture)

---

## 📦 What it does

### 🔹 SchemaCast
- Unwraps `{ status: {...}, data: ... }` → uses only `data`.
- Infers nested objects/lists → generates DTOs + Entities.
- **DTOs**
  - All fields nullable (`String?`, `int?`).
  - Mirrors API response closely.
- **Entities**
  - Non-nullable by default (`required int count`).
  - Nullable if samples contain `null` (or `""` for strings).
  - Numeric promotion:
    - `double` if any decimal seen,
    - otherwise `int`.
  - Converts numeric strings (e.g., `"08"`, `"08.89"`) into numbers during `toEntity()`.
  - Nested objects → separate sub-entities (imports auto-added).
  - No `.g.dart` or `fromJson` in entities → clean domain-only models.

### 🔹 Seed
- Creates **feature skeletons** following Clean Architecture:
