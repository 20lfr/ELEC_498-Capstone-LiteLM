# Synth Warning Summary

Source log: `Vitis-Synthesis-Logs/Synth.logs`

Full warning extract with original line numbers: `Vitis-Synthesis-Logs/Synth_warnings.txt`

This summary groups repeated warnings by ID and explains what each one means.

## Warning Groups

- `v++ 60-2507` (`1` occurrence)
  `Dispatch failed to load the system diagram library librdi_system_diagram. Diagrams will not be produced.`
  Description: The Vitis GUI/system-diagram component is missing or not loadable in this install. This does not usually block HLS synthesis; it only disables generated diagrams.

- `HLS 207-5292` (`1` occurrence)
  `unused parameter 'head'`
  Description: A function argument is declared but never used. This is usually harmless, but it may indicate dead code or an incomplete feature path.

- `HLS 207-1016` (`1` occurrence)
  `unknown warning group '-Wmisleading-indentation', ignored`
  Description: The HLS frontend does not recognize that warning flag, so it ignores it. This is a toolchain compatibility warning, not a hardware bug by itself.

- `HLS 200-1995` (`4` occurrences)
  `There were ... instructions in the design after ... phase of compilation.`
  Description: The design is large during compilation. This is a scale/complexity warning that often correlates with long compile time and harder scheduling, but it is not itself a functional failure.

- `HLS 214-322` (`2` occurrences)
  `Unsupported scalar variable on pragma 'Resource/Bind_Storage', ignore it.`
  Description: A storage/resource pragma was applied to a scalar, and HLS ignored it. The intended binding directive is not taking effect at those source locations.

- `HLS 214-358` (`4` occurrences)
  `Array transformation on index using bit extension logic may lead to poor performance.`
  Description: Some array indices are computed with narrow or extended integer types, which limits optimization. Using `int` or `long` for index arithmetic usually gives HLS better optimization freedom.

- `SYNCHK 200-23` (`1` occurrence)
  `variable-indexed range selection may cause suboptimal QoR`
  Description: A dynamic bit-range select prevents cleaner hardware inference. The design will still synthesize, but area or timing may be worse than with constant or simplified indexing.

- `XFORM 203-561` (`9` occurrences)
  `Updating loop lower bound ...`, `Updating loop upper bound ...`, `Ignored invalid trip count directive ...`
  Description: HLS adjusted inferred loop bounds or rejected an invalid tripcount directive. This usually means the provided loop metadata does not match what the compiler could prove from the code.

- `HLS 200-960` (`2` occurrences)
  `Cannot flatten loop ... the outer loop is not a perfect loop ...`
  Description: HLS could not flatten nested loops because extra logic exists around the inner loop. This is a performance optimization miss, not a correctness issue.

- `SYN 201-103` (`62` occurrences)
  `Legalizing function name ...`
  Description: HLS renamed C++ symbols into RTL-safe names. This is normal for templates, anonymous namespaces, and symbols containing characters that are invalid in generated RTL names.

- `SYN 201-303` (`1114` occurrences)
  `Cannot apply memory assignment of 'RAM_T2P_BRAM' ... which is not an array.`
  Description: A BRAM binding directive is being applied to objects that are not arrays, so HLS ignores it. This is one of the most actionable warnings in the log because the intended memory implementation constraint is not being honored.

- `HLS 200-880` (`29` occurrences)
  `The II Violation ... Unable to enforce a carried dependence constraint ...`
  Description: HLS could not achieve the requested or implied initiation interval because loop-carried dependencies, bus dependencies, or read/write hazards force extra cycles between iterations. This is a direct performance warning and one of the main reasons loop throughput is below target.

- `HLS 200-2042` (`17` occurrences)
  `Usage of URAM can potentially cause worse II ... Consider using BRAMs instead.`
  Description: URAM was selected for some storage, but Vitis HLS warns that URAM behavior can hurt loop II because read-first mode is not exploited. This is a performance tradeoff warning and is closely related to the II violations in the design.

- `HLS 200-885` (`4` occurrences)
  `The II Violation ... due to limited memory ports ...`
  Description: HLS could not schedule enough reads in one cycle because the memory has too few ports. Array partitioning, reshaping, duplication, or a different memory core can reduce these stalls.

- `RTGEN 206-101` (`487` occurrences)
  `Register ... is power-on initialization.`
  Description: Generated RTL includes registers with power-on initial values. This is often informational in practice, but it matters if your downstream flow or target device has restrictions on initialization behavior.

## Most Actionable Warnings

- `SYN 201-303`: binding directives are being ignored because the targets are not arrays.
- `HLS 200-880`: loop-carried or interface dependencies are preventing the desired II.
- `HLS 200-885`: memory port limits are stalling pipelined loops.
- `HLS 200-2042`: URAM choice may be contributing to the II problems.
