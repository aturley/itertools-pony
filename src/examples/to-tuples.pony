use "../itertools-pony"

actor MainToTuples
  new create(env: Env) =>
    (let a0, let b0, let c0) = try
      if env.args.size() != 4 then
        (env.args(1), env.args(2), env.args(3))
      else
        error
      end
    else
      env.err.print("must have 3 args")
      return
    end

    (let a1, let b1, let c1) = try
      match (env.args(1), env.args(2), env.args(3), env.args.size())
      | (let a': String, let b': String, let c': String, 4) => (a', b', c')
      else
        error
      end
    else
      env.err.print("must have 3 args")
      return
    end

    (_, let a2, let b2, let c2) = try
      env.args.to_tuple_4_error()
    else
      env.err.print("must have 3 args")
      return
    end

    (let a3, let b3, let c3) = match env.args.to_tuple_4_none()
    | (_, let a', let b', let c') if (env.args.size() == 4) =>
      (a', b', c')
    else
      env.err.print("must have 3 args")
      return
    end

    (let a4, let b4, let c4) = match env.args.to_tuple_4_none()
    | (_, let a', let b', let c') if c' isnt None => (a', b', c')
    else
      env.err.print("must have 3 args")
      return
    end

    let tt = ToTuple3[String, String, String](Drop(env.args.values(), 1))
    (let a5, let b5, let c5) = try
      match tt.next()
      | (let a', let b', let c') if not tt.has_next() =>
        (a', b', c')
      else
        error
      end
    else
      env.err.print("must have 3 args")
      return
    end


