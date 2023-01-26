; ModuleID = "Shellcode"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i32 @"main"(i32 %".1")
{
.3:
  %".4" = alloca i32*
  %".5" = alloca i32, i32 4
  %".6" = ptrtoint i32* %".5" to i32
  %".7" = add i32 %".6", 0
  ret i32 1
}
