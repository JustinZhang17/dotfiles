# Style Conventions

Detailed formatting and typography rules live in the parent `STYLE.md`. This
file covers style decisions specific to writing code that the general guide
leaves open.

## Ordering

- Within a file: standard library → third-party → local imports, unless the
  language or repo dictates otherwise. Stay consistent with the file.
- Group related declarations together; do not interleave types, helpers, and
  the main logic.

## Functions

- Functions do one thing. If you wrote "and" in the name, consider splitting.
- Argument lists: ≤ ~4 ideal; beyond that, introduce a parameter object/struct.
- No boolean flag parameters; split into two named functions or use an enum.
- Early returns are preferred over deep nesting.

## Error handling

- Do not return `null` to signal error: throw/raise, return `Result`/`Either`,
  or use the language's idiomatic error type.
- Catch at the boundary that can act on the error; never swallow silently.
- Log the stack/cause once at the boundary; lower layers attach context.

## Generics & metaprogramming

- Use the least powerful mechanism that solves it. Plain function before
  generic, generic before macro/reflection.
- Prefer composing small functions over building a clever one.

## Anti-patterns

- **Deep if/else chains and excessive guard clauses.** Flatten with early
  returns or data-driven dispatch (table lookups, polymorphism), not nested
  conditionals that grow one branch at a time.
- **Hard-coded workarounds for specific inputs.** `if input == "that-one-bad-value"`
  belongs in the data or the type, not an ever-growing special-case list.
- **Speculative parameters and config flags "for later".** Add them when the
  need is real; remove them when it never arrives.
- **Blanket try/catch "just in case."** Catch what you can act on, at the
  boundary; never swallow the rest to silence a failure.
- **Clever one-liners that the next reader must decode.** Prefer the boring,
  obvious solution.

## Consistency

- When the repo disagrees with this guide, the repo wins. Note the divergence
  in a comment only if it is surprising.