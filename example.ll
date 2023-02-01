; ModuleID = "Shellcode"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i32 @"main"()
{
.2:
  %".3" = alloca i32
  %".4" = trunc i64 5 to i32
  store i32 %".4", i32* %".3"
  %".6" = alloca i32
  %".7" = trunc i64 4 to i32
  store i32 %".7", i32* %".6"
  %".9" = load i32, i32* %".3"
  call void asm sideeffect "", "{eax}"
(i32 %".9")
  call void asm  "mov %fs:48, %ebx", ""
()
  %".12" = call i32 asm  "", "={ebx}"
()
  store i32 %".12", i32* %".6"
  %".14" = load i32, i32* %".6"
  ret i32 %".14"
}
