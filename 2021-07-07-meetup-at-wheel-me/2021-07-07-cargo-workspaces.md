# Brief introduction to Cargo workspaces

Erik Vesteraas - Rust Oslo - 2021-07-07

---

## Hello / Who am I

- Erik Vesteraas / <https://github.com/evestera>
- One of the organizers of this meetup (I have stickers)
- Tech lead at Porterbuddy
- Have used Rust since ~1.0

---

## What are Cargo workspaces?

- Multiple crates managed together
- Shared Cargo.lock and output directory
  - Shared compilation cache
- Internal path dependencies allowed

---

## Resources

- "The book" / TRPL chapter: <https://doc.rust-lang.org/book/ch14-03-cargo-workspaces.html>
- Cargo reference: <https://doc.rust-lang.org/cargo/reference/workspaces.html>

## Examples

- [github.com/serde-rs/serde](https://github.com/serde-rs/serde)
- [github.com/BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- My own projects:
  - [github.com/evestera/json_typegen](https://github.com/evestera/json_typegen)
  - [github.com/evestera/svg-halftone](https://github.com/evestera/svg-halftone)

---

## Creating

Make a root `Cargo.toml` with a `[workspace]` section.

The root can be a package itself, or just declare a workspace.

```
[workspace]
members = [
    "json_typegen_shared", "json_typegen_cli", "json_typegen",
]
```

If the root is a crate itself, you can omit `members`,
in which case the workspace will be the root crate and its path dependencies.

---

```
mkdir workspace-demo
cd workspace-demo
git init
echo '[workspace]' >>Cargo.toml
echo 'members = ["alpha", "bravo"]' >>Cargo.toml
cargo new alpha
cargo new --lib bravo
cargo build
```

---

## Path dependencies

- crates.io does not allow crates with path or git dependencies*,
  but you can have internal path dependencies in a workspace

```
[dependencies]
json_typegen_shared = { path = "../json_typegen_shared" }
```

*: You can specify dependencies with a path/gitpath AND a version:
  see <https://doc.rust-lang.org/cargo/reference/specifying-dependencies.html#multiple-locations>

---

## Publishing

- Has to be done one crate at a time
  - Leaves first
- You can have a combination of published and unpublished crates (e.g. a demo crate)
- But you can't publish a crate with an unpublished dependency.
  - No way to have a "private" shared crate or internal API
- Each crate has to have the necessary files (README etc)
  - Symlinking is possible for some files

---

# Edge cases / caveats

- You can't have different compilation settings per crate (e.g. size vs speed)
- Feature unification (see rust 1.50 `resolver = "2"`)

---

## Questions?
