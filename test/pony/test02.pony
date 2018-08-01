       // vim:debug=msg
        type A is (I32 | U32)
type B is ((
     Good & Bad
        ) |
 Nothing |
  Fine
  )
  use "collections"
    use time = "time"

actor Main
// TODO: Indent me!
/**
   */
  """
  hello
  """
"""
world
"""
  new hi(env''': Env,
x: String,
  s: String)
 => 3
iftype A <: B then
  // Generate this block if A is a subtype of B.
  // A is constrained to B in this block.
    elseiftype B <: (C & D)
                else
  // Generate this block otherwise
  //if
  if true then
  else
  end
                end

  fun ref no() =>
    /**
   * comment
       */
    let s''''''''''' = "hi"
"hi"
let fn = lambda (s: String): Bool => x.size() > 3 end
let k = Main(env)
let a = object
  let b = object
fun hi() => None
      new hi() => None
      be hi() =>
    let c = object
      let d: U8 = 8
      end
let notify = object iso
fun ref apply(data: Array[U8] iso) => consume data
fun ref dispose() => None
end
end
end
fun foo(x: A): B iftype A <: B => // A is constrained to B in this specialisation.
  "great"

  new create(env: Env) =>
    let child_pid = @fork[I32]()
    match child_pid
| -1 =>
          env.err.print("Failed to fork the process")
          if true then
        env.exitcode(((1))//(
)
    else
      env.exitcode(0)
            end
      | 0 if true =>
      /*/---- Note
     * Calling pony functions in the child is not thread-safe?
         * /*
       *  * TODO something /* XXX: hi */
       FIXME
         *  */
     *------------*/
      //env.out.print("This sentence is true.")
      @printf[I32]("This sentence is true.\n".cstring())
    @_exit[None](I32(-1))
    else
        var wstatus: I32 = 0
      let woption: I32 = 0
        if @waitpid[I32](child_pid, addressof wstatus, woption) < 0 then
          env.err.print("Failed to wait for the child process")
          env.exitcode(1)
        else
          env.out.print("This sentence is false.")
          env.out.print("The child process exited with status: " +
              ((wstatus >> 8) and 0xFF).string())
        end
    end
"""A""""
""""""""
"""B""""
        fun foo(x: A): B => // Default function. Optional.
          None
