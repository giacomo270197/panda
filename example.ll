; ModuleID = "Shellcode"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i32 @"find_function"(i32 %".1", i32 %".2")
{
.4:
  %".5" = alloca i32
  store i32 %".1", i32* %".5"
  %".7" = alloca i32
  store i32 %".2", i32* %".7"
  %"pe_signature" = alloca i32
  %".9" = load i32, i32* %".5"
  %".10" = trunc i64 60 to i32
  %".11" = add i32 %".9", %".10"
  %".12" = inttoptr i32 %".11" to i32*
  %".13" = load i32, i32* %".12"
  store i32 %".13", i32* %"pe_signature"
  %".15" = load i32, i32* %"pe_signature"
  %".16" = load i32, i32* %".5"
  %".17" = add i32 %".15", %".16"
  store i32 %".17", i32* %"pe_signature"
  %"etd" = alloca i32
  %".19" = load i32, i32* %"pe_signature"
  %".20" = trunc i64 120 to i32
  %".21" = add i32 %".19", %".20"
  %".22" = inttoptr i32 %".21" to i32*
  %".23" = load i32, i32* %".22"
  store i32 %".23", i32* %"etd"
  %".25" = load i32, i32* %"etd"
  %".26" = load i32, i32* %".5"
  %".27" = add i32 %".25", %".26"
  store i32 %".27", i32* %"etd"
  %"number_of_names" = alloca i32
  %".29" = load i32, i32* %"etd"
  %".30" = trunc i64 24 to i32
  %".31" = add i32 %".29", %".30"
  %".32" = inttoptr i32 %".31" to i32*
  %".33" = load i32, i32* %".32"
  store i32 %".33", i32* %"number_of_names"
  %"address_of_names" = alloca i32
  %".35" = load i32, i32* %"etd"
  %".36" = trunc i64 32 to i32
  %".37" = add i32 %".35", %".36"
  %".38" = inttoptr i32 %".37" to i32*
  %".39" = load i32, i32* %".38"
  store i32 %".39", i32* %"address_of_names"
  %".41" = load i32, i32* %"address_of_names"
  %".42" = load i32, i32* %".5"
  %".43" = add i32 %".41", %".42"
  store i32 %".43", i32* %"address_of_names"
  %".45" = load i32, i32* %"number_of_names"
  %".46" = trunc i64 1 to i32
  %".47" = sub i32 %".45", %".46"
  store i32 %".47", i32* %"number_of_names"
  %".49" = load i32, i32* %"number_of_names"
  %".50" = icmp ugt i32 %".49", 0
  br i1 %".50", label %"loop_1", label %"loop_after_1"
loop_1:
  %"symbol_name" = alloca i32
  %".52" = load i32, i32* %"address_of_names"
  %".53" = load i32, i32* %"number_of_names"
  %".54" = trunc i64 4 to i32
  %".55" = mul i32 %".53", %".54"
  %".56" = add i32 %".52", %".55"
  store i32 %".56", i32* %"symbol_name"
  %".58" = load i32, i32* %".5"
  %".59" = load i32, i32* %"symbol_name"
  %".60" = inttoptr i32 %".59" to i32*
  %".61" = load i32, i32* %".60"
  %".62" = add i32 %".58", %".61"
  store i32 %".62", i32* %"symbol_name"
  %".64" = load i32, i32* %"number_of_names"
  %".65" = trunc i64 1 to i32
  %".66" = sub i32 %".64", %".65"
  store i32 %".66", i32* %"number_of_names"
  %".68" = load i32, i32* %"number_of_names"
  %".69" = icmp ugt i32 %".68", 0
  br i1 %".69", label %"loop_1", label %"loop_after_1"
loop_after_1:
  %".71" = load i32, i32* %"pe_signature"
  ret i32 %".71"
}

define i32 @"main"()
{
.2:
  %"pointer" = alloca i32
  %".3" = trunc i64 0 to i32
  store i32 %".3", i32* %"pointer"
  %".5" = load i32, i32* %"pointer"
  call void asm sideeffect "", "{eax}"
(i32 %".5")
  call void asm  "mov %fs:48, %eax", ""
()
  %".8" = call i32 asm  "", "={eax}"
()
  store i32 %".8", i32* %"pointer"
  %".10" = load i32, i32* %"pointer"
  %".11" = trunc i64 12 to i32
  %".12" = add i32 %".10", %".11"
  %".13" = inttoptr i32 %".12" to i32*
  %".14" = load i32, i32* %".13"
  store i32 %".14", i32* %"pointer"
  %".16" = load i32, i32* %"pointer"
  %".17" = trunc i64 28 to i32
  %".18" = add i32 %".16", %".17"
  %".19" = inttoptr i32 %".18" to i32*
  %".20" = load i32, i32* %".19"
  store i32 %".20", i32* %"pointer"
  %"base_address" = alloca i32
  %".22" = load i32, i32* %"pointer"
  %".23" = trunc i64 8 to i32
  %".24" = add i32 %".22", %".23"
  %".25" = inttoptr i32 %".24" to i32*
  %".26" = load i32, i32* %".25"
  store i32 %".26", i32* %"base_address"
  %"module_name" = alloca i32
  %".28" = load i32, i32* %"pointer"
  %".29" = trunc i64 32 to i32
  %".30" = add i32 %".28", %".29"
  %".31" = inttoptr i32 %".30" to i32*
  %".32" = load i32, i32* %".31"
  store i32 %".32", i32* %"module_name"
  %"guard" = alloca i8
  %".34" = trunc i64 0 to i8
  store i8 %".34", i8* %"guard"
  %".36" = load i8, i8* %"guard"
  %".37" = icmp eq i8 %".36", 0
  br i1 %".37", label %"loop_2", label %"loop_after_2"
loop_2:
  %".39" = load i32, i32* %"pointer"
  %".40" = inttoptr i32 %".39" to i32*
  %".41" = load i32, i32* %".40"
  store i32 %".41", i32* %"pointer"
  %".43" = load i32, i32* %"pointer"
  %".44" = trunc i64 8 to i32
  %".45" = add i32 %".43", %".44"
  %".46" = inttoptr i32 %".45" to i32*
  %".47" = load i32, i32* %".46"
  store i32 %".47", i32* %"base_address"
  %".49" = load i32, i32* %"pointer"
  %".50" = trunc i64 32 to i32
  %".51" = add i32 %".49", %".50"
  %".52" = inttoptr i32 %".51" to i32*
  %".53" = load i32, i32* %".52"
  store i32 %".53", i32* %"module_name"
  %"char" = alloca i8
  %".55" = load i32, i32* %"module_name"
  %".56" = trunc i64 24 to i32
  %".57" = add i32 %".55", %".56"
  %".58" = inttoptr i32 %".57" to i32*
  %".59" = load i32, i32* %".58"
  %".60" = trunc i32 %".59" to i8
  store i8 %".60", i8* %"char"
  %".62" = load i8, i8* %"char"
  %".63" = icmp eq i8 %".62", 0
  br i1 %".63", label %"loop_2.if", label %"loop_2.else"
loop_after_2:
  %"zero" = alloca i32
  %".72" = trunc i64 3960360590 to i32
  store i32 %".72", i32* %"zero"
  %"a" = alloca i32
  %".74" = load i32, i32* %"base_address"
  %".75" = load i32, i32* %"zero"
  %".76" = call i32 @"find_function"(i32 %".74", i32 %".75")
  store i32 %".76", i32* %"a"
  %".78" = load i32, i32* %"a"
  ret i32 %".78"
loop_2.if:
  %".65" = trunc i64 1 to i8
  store i8 %".65", i8* %"guard"
  br label %"loop_2.endif"
loop_2.else:
  br label %"loop_2.endif"
loop_2.endif:
  %".69" = load i8, i8* %"guard"
  %".70" = icmp eq i8 %".69", 0
  br i1 %".70", label %"loop_2", label %"loop_after_2"
}
