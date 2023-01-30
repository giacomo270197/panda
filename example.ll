; ModuleID = "Shellcode"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i32* @"add"(i32 %".1", i32 %".2")
{
.4:
  %".5" = alloca i32
  store i32 %".1", i32* %".5"
  %".7" = alloca i32
  store i32 %".2", i32* %".7"
  %".9" = alloca i32
  %".10" = icmp ugt i32 %".1", %".2"
  br i1 %".10", label %".4.if", label %".4.else"
.4.if:
  %".12" = add i32 %".1", %".2"
  store i32 %".12", i32* %".9"
  br label %".4.endif"
.4.else:
  %".15" = sub i32 %".1", %".2"
  store i32 %".15", i32* %".9"
  br label %".4.endif"
.4.endif:
  ret i32* %".9"
}

define i32 @"main"()
{
.2:
  %".3" = alloca i32
  %".4" = trunc i64 5 to i32
  store i32 %".4", i32* %".3"
  %".6" = alloca i32
  %".7" = trunc i64 4 to i32
  store i32 %".7", i32* %".6"
  %".9" = alloca i32*
  %".10" = call i32* @"add"(i32 %".4", i32 %".7")
  store i32* %".10", i32** %".9"
  %".12" = load i32, i32* %".10"
  ret i32 %".12"
}
