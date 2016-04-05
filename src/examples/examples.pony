use "../itertools-pony"

actor Main
  new create(env: Env) =>
    let i1 = [as I32: 1, 2, 3, 4]
    let i2 = [as I32: 5, 6, 7, 8, 9]
    let i3 = [as I32: 10, 11, 12, 13, 14]
    var i4: Array[I32] ref = [as I32: 1, 2, 3]
    var i5: Array[String] ref = ["a", "b", "q", "f"]
    var i6: Array[F32] ref = [as F32: 4.2, 5.7, 6.1]

    for x in Chain[I32]([i1.values(), i2.values(), i3.values()].values()) do
      env.out.print(x.string())
    end

    for x in Take[I32](i3.values(), 3) do
      env.out.print(x.string())
    end

    for (x, y) in Zip2[I32, String](i4.values(), i5.values()) do
      env.out.print("".add(x.string()).add(" ").add(y))
    end

    for (x, y, z) in Zip3[I32, String, F32](i4.values(), i5.values(), i6.values()) do
      env.out.print("".add(x.string()).add(" ").add(y).add(" ").add(z.string()))
    end

    for x in Take[U32](Repeat[U32](7), 5) do
      env.out.print(x.string())
    end

    for x in Take[I32](Cycle[I32](i1.values()), 15) do
      env.out.print(x.string())
    end