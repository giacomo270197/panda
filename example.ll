; ModuleID = "Shellcode"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i32 @"compute_function_hash"(i32 %".1")
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

define i32 @"compute_module_hash"(i32 %".1")
{
.3:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %"hash" = alloca i32
  store i32 0, i32* %"hash"
  %"cnt" = alloca i8
  store i8 0, i8* %"cnt"
  %"char" = alloca i16
  %".8" = load i32, i32* %".4"
  %".9" = load i8, i8* %"cnt"
  %".10" = zext i8 %".9" to i32
  %".11" = add i32 %".8", %".10"
  %".12" = inttoptr i32 %".11" to i16*
  %".13" = load i16, i16* %".12"
  store i16 %".13", i16* %"char"
  %".15" = load i16, i16* %"char"
  %".16" = icmp ne i16 %".15", 0
  br i1 %".16", label %"loop_2", label %"loop_after_2"
loop_2:
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
  %".28" = load i16, i16* %"char"
  %".29" = zext i16 %".28" to i32
  %".30" = add i32 %".27", %".29"
  store i32 %".30", i32* %"hash"
  %".32" = load i8, i8* %"cnt"
  %".33" = zext i8 %".32" to i64
  %".34" = add i64 %".33", 2
  %".35" = trunc i64 %".34" to i8
  store i8 %".35", i8* %"cnt"
  %".37" = load i32, i32* %".4"
  %".38" = load i8, i8* %"cnt"
  %".39" = zext i8 %".38" to i32
  %".40" = add i32 %".37", %".39"
  %".41" = inttoptr i32 %".40" to i16*
  %".42" = load i16, i16* %".41"
  store i16 %".42", i16* %"char"
  %".44" = load i16, i16* %"char"
  %".45" = icmp ne i16 %".44", 0
  br i1 %".45", label %"loop_2", label %"loop_after_2"
loop_after_2:
  %".47" = load i32, i32* %"hash"
  ret i32 %".47"
}

define i32 @"find_module_base"(i32 %".1")
{
.3:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %"pointer" = alloca i32
  store i32 0, i32* %"pointer"
  %".7" = load i32, i32* %"pointer"
  call void asm sideeffect "", "{eax}"
(i32 %".7")
  call void asm  "mov %fs:48, %eax", ""
()
  %".10" = call i32 asm  "", "={eax}"
()
  store i32 %".10", i32* %"pointer"
  %".12" = load i32, i32* %"pointer"
  %".13" = zext i32 %".12" to i64
  %".14" = add i64 %".13", 12
  %".15" = inttoptr i64 %".14" to i32*
  %".16" = load i32, i32* %".15"
  store i32 %".16", i32* %"pointer"
  %".18" = load i32, i32* %"pointer"
  %".19" = zext i32 %".18" to i64
  %".20" = add i64 %".19", 28
  %".21" = inttoptr i64 %".20" to i32*
  %".22" = load i32, i32* %".21"
  store i32 %".22", i32* %"pointer"
  %"base_address" = alloca i32
  %".24" = load i32, i32* %"pointer"
  %".25" = zext i32 %".24" to i64
  %".26" = add i64 %".25", 8
  %".27" = inttoptr i64 %".26" to i32*
  %".28" = load i32, i32* %".27"
  store i32 %".28", i32* %"base_address"
  %"module_name" = alloca i32
  %".30" = load i32, i32* %"pointer"
  %".31" = zext i32 %".30" to i64
  %".32" = add i64 %".31", 32
  %".33" = inttoptr i64 %".32" to i32*
  %".34" = load i32, i32* %".33"
  store i32 %".34", i32* %"module_name"
  %"guard" = alloca i8
  store i8 0, i8* %"guard"
  %".37" = load i8, i8* %"guard"
  %".38" = icmp eq i8 %".37", 0
  br i1 %".38", label %"loop_3", label %"loop_after_3"
loop_3:
  %".40" = load i32, i32* %"pointer"
  %".41" = inttoptr i32 %".40" to i32*
  %".42" = load i32, i32* %".41"
  store i32 %".42", i32* %"pointer"
  %".44" = load i32, i32* %"pointer"
  %".45" = zext i32 %".44" to i64
  %".46" = add i64 %".45", 8
  %".47" = inttoptr i64 %".46" to i32*
  %".48" = load i32, i32* %".47"
  store i32 %".48", i32* %"base_address"
  %".50" = load i32, i32* %"pointer"
  %".51" = zext i32 %".50" to i64
  %".52" = add i64 %".51", 32
  %".53" = inttoptr i64 %".52" to i32*
  %".54" = load i32, i32* %".53"
  store i32 %".54", i32* %"module_name"
  %"computed_hash" = alloca i32
  %".56" = load i32, i32* %"module_name"
  %".57" = call i32 @"compute_module_hash"(i32 %".56")
  store i32 %".57", i32* %"computed_hash"
  %".59" = load i32, i32* %"computed_hash"
  %".60" = load i32, i32* %".4"
  %".61" = icmp eq i32 %".59", %".60"
  br i1 %".61", label %"loop_3.if", label %"loop_3.else"
loop_after_3:
  ret i32 0
loop_3.if:
  %".63" = load i32, i32* %"base_address"
  ret i32 %".63"
loop_3.else:
  br label %"loop_3.endif"
loop_3.endif:
  %".66" = load i8, i8* %"guard"
  %".67" = icmp eq i8 %".66", 0
  br i1 %".67", label %"loop_3", label %"loop_after_3"
}

define i32 @"find_function"(i32 %".1", i32 %".2")
{
.4:
  %".5" = alloca i32
  store i32 %".1", i32* %".5"
  %".7" = alloca i32
  store i32 %".2", i32* %".7"
  %"base_address" = alloca i32
  %".9" = load i32, i32* %".7"
  %".10" = call i32 @"find_module_base"(i32 %".9")
  store i32 %".10", i32* %"base_address"
  %"pe_signature" = alloca i32
  %".12" = load i32, i32* %"base_address"
  %".13" = zext i32 %".12" to i64
  %".14" = add i64 %".13", 60
  %".15" = inttoptr i64 %".14" to i32*
  %".16" = load i32, i32* %".15"
  store i32 %".16", i32* %"pe_signature"
  %".18" = load i32, i32* %"pe_signature"
  %".19" = load i32, i32* %"base_address"
  %".20" = add i32 %".18", %".19"
  store i32 %".20", i32* %"pe_signature"
  %"export_table_directory" = alloca i32
  %".22" = load i32, i32* %"pe_signature"
  %".23" = zext i32 %".22" to i64
  %".24" = add i64 %".23", 120
  %".25" = inttoptr i64 %".24" to i32*
  %".26" = load i32, i32* %".25"
  store i32 %".26", i32* %"export_table_directory"
  %".28" = load i32, i32* %"export_table_directory"
  %".29" = load i32, i32* %"base_address"
  %".30" = add i32 %".28", %".29"
  store i32 %".30", i32* %"export_table_directory"
  %"number_of_names" = alloca i32
  %".32" = load i32, i32* %"export_table_directory"
  %".33" = zext i32 %".32" to i64
  %".34" = add i64 %".33", 24
  %".35" = inttoptr i64 %".34" to i32*
  %".36" = load i32, i32* %".35"
  store i32 %".36", i32* %"number_of_names"
  %"address_of_names" = alloca i32
  %".38" = load i32, i32* %"export_table_directory"
  %".39" = zext i32 %".38" to i64
  %".40" = add i64 %".39", 32
  %".41" = inttoptr i64 %".40" to i32*
  %".42" = load i32, i32* %".41"
  store i32 %".42", i32* %"address_of_names"
  %".44" = load i32, i32* %"address_of_names"
  %".45" = load i32, i32* %"base_address"
  %".46" = add i32 %".44", %".45"
  store i32 %".46", i32* %"address_of_names"
  %".48" = load i32, i32* %"number_of_names"
  %".49" = zext i32 %".48" to i64
  %".50" = sub i64 %".49", 1
  %".51" = trunc i64 %".50" to i32
  store i32 %".51", i32* %"number_of_names"
  %".53" = load i32, i32* %"number_of_names"
  %".54" = icmp ugt i32 %".53", 0
  br i1 %".54", label %"loop_4", label %"loop_after_4"
loop_4:
  %"symbol_name" = alloca i32
  %".56" = load i32, i32* %"address_of_names"
  %".57" = load i32, i32* %"number_of_names"
  %".58" = zext i32 %".57" to i64
  %".59" = mul i64 %".58", 4
  %".60" = zext i32 %".56" to i64
  %".61" = add i64 %".60", %".59"
  %".62" = trunc i64 %".61" to i32
  store i32 %".62", i32* %"symbol_name"
  %".64" = load i32, i32* %"base_address"
  %".65" = load i32, i32* %"symbol_name"
  %".66" = inttoptr i32 %".65" to i32*
  %".67" = load i32, i32* %".66"
  %".68" = add i32 %".64", %".67"
  store i32 %".68", i32* %"symbol_name"
  %"computed" = alloca i32
  %".70" = load i32, i32* %"symbol_name"
  %".71" = call i32 @"compute_function_hash"(i32 %".70")
  store i32 %".71", i32* %"computed"
  %".73" = load i32, i32* %"computed"
  %".74" = load i32, i32* %".5"
  %".75" = icmp eq i32 %".73", %".74"
  br i1 %".75", label %"loop_4.if", label %"loop_4.else"
loop_after_4:
  ret i32 0
loop_4.if:
  %"address_of_name_ordinal" = alloca i32
  %".77" = load i32, i32* %"export_table_directory"
  %".78" = zext i32 %".77" to i64
  %".79" = add i64 %".78", 36
  %".80" = inttoptr i64 %".79" to i32*
  %".81" = load i32, i32* %".80"
  store i32 %".81", i32* %"address_of_name_ordinal"
  %".83" = load i32, i32* %"address_of_name_ordinal"
  %".84" = load i32, i32* %"base_address"
  %".85" = add i32 %".83", %".84"
  store i32 %".85", i32* %"address_of_name_ordinal"
  %"ordinal" = alloca i16
  %".87" = load i32, i32* %"address_of_name_ordinal"
  %".88" = load i32, i32* %"number_of_names"
  %".89" = zext i32 %".88" to i64
  %".90" = mul i64 2, %".89"
  %".91" = zext i32 %".87" to i64
  %".92" = add i64 %".91", %".90"
  %".93" = inttoptr i64 %".92" to i16*
  %".94" = load i16, i16* %".93"
  store i16 %".94", i16* %"ordinal"
  %"address_of_functions" = alloca i32
  %".96" = load i32, i32* %"export_table_directory"
  %".97" = zext i32 %".96" to i64
  %".98" = add i64 %".97", 28
  %".99" = inttoptr i64 %".98" to i32*
  %".100" = load i32, i32* %".99"
  store i32 %".100", i32* %"address_of_functions"
  %".102" = load i32, i32* %"address_of_functions"
  %".103" = load i32, i32* %"base_address"
  %".104" = add i32 %".102", %".103"
  store i32 %".104", i32* %"address_of_functions"
  %"function_address" = alloca i32
  %".106" = load i32, i32* %"address_of_functions"
  %".107" = load i16, i16* %"ordinal"
  %".108" = zext i16 %".107" to i64
  %".109" = mul i64 4, %".108"
  %".110" = zext i32 %".106" to i64
  %".111" = add i64 %".110", %".109"
  %".112" = inttoptr i64 %".111" to i32*
  %".113" = load i32, i32* %".112"
  store i32 %".113", i32* %"function_address"
  %".115" = load i32, i32* %"function_address"
  %".116" = load i32, i32* %"base_address"
  %".117" = add i32 %".115", %".116"
  store i32 %".117", i32* %"function_address"
  %".119" = load i32, i32* %"function_address"
  ret i32 %".119"
loop_4.else:
  br label %"loop_4.endif"
loop_4.endif:
  %".122" = load i32, i32* %"number_of_names"
  %".123" = zext i32 %".122" to i64
  %".124" = sub i64 %".123", 1
  %".125" = trunc i64 %".124" to i32
  store i32 %".125", i32* %"number_of_names"
  %".127" = load i32, i32* %"number_of_names"
  %".128" = icmp ugt i32 %".127", 0
  br i1 %".128", label %"loop_4", label %"loop_after_4"
}

define i32 @"main"()
{
.2:
  %"kernel32_hash" = alloca i32
  store i32 1848363543, i32* %"kernel32_hash"
  %"load_library_hash" = alloca i32
  store i32 3960360590, i32* %"load_library_hash"
  %"a" = alloca i32
  %".5" = load i32, i32* %"load_library_hash"
  %".6" = load i32, i32* %"kernel32_hash"
  %".7" = call i32 @"find_function"(i32 %".5", i32 %".6")
  store i32 %".7", i32* %"a"
  %".9" = load i32, i32* %"a"
  ret i32 %".9"
}
