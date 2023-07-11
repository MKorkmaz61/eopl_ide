class Type_Example {
  String lang = "";
  String code = "";

  Type_Example(String lang, String code) {
    this.lang = lang;
    this.code = code;
  }
}

class Code_Examples {
  static var example_dict = {
    "PROC_1": Type_Example("proc", "(proc(x) -(x,1)  30)"),
    "PROC_2": Type_Example("proc", "(proc(f)(f 30)  proc(x)-(x,1))"),
    "LET_1": Type_Example("let", "let x = -(4,1) in -(x,1)"),
    "LET_2": Type_Example("let", "let x = 3 in let x = -(x,1) in x"),
    "LETREC_1": Type_Example("letrec", "letrec f(x) = -(x,1) in (f 33)"),
    "LETREC_2": Type_Example("letrec",
        "letrec f(x) = if zero?(x)  then 0 else -((f -(x,1)), -2) in (f 4)"),
    "CALL_BY_NEED_EXAMPLE_1":
        Type_Example("call-by-need", "let p = newpair(22,33) in left(p)"),
    "CALL_BY_NEED_EXAMPLE_2": Type_Example("call-by-need",
        "let p = newpair(22,33) in begin setleft p = 77; left(p) end"),
    "CALL_BY_REF_EXAMPLE_1": Type_Example(
        "call-by-reference",
        "let swap = proc (x) proc (y)\n                      let temp = x\n                      in begin \n                          set x = y;\n                          set y = temp\n                         end\n         in let a = 33\n         in let b = 44\n         in begin\n             ((swap a) b);\n             -(a,b)\n            end"),
    "CALL_BY_REF_EXAMPLE_2": Type_Example(
        "call-by-reference",
        "let p = proc (z) set z = 44\n         in let x = 33\n         in begin (p x); x end")
  };
}
