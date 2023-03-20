; ModuleID = "Shellcode"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i32 @"compute_function_hash"(i32 %".1")
{
.3:
  %"hash" = alloca i32
  store i32 0, i32* %"hash"
  %"cnt" = alloca i8
  store i8 0, i8* %"cnt"
  %"char" = alloca i8
  %".6" = load i8, i8* %"cnt"
  %".7" = zext i8 %".6" to i32
  %".8" = add i32 %".1", %".7"
  %".9" = inttoptr i32 %".8" to i8*
  %".10" = load i8, i8* %".9"
  store i8 %".10", i8* %"char"
  %".12" = load i8, i8* %"char"
  %".13" = icmp ne i8 %".12", 0
  br i1 %".13", label %"loop_1", label %"loop_after_1"
loop_1:
  %".15" = load i32, i32* %"hash"
  %".16" = zext i32 %".15" to i64
  %".17" = ashr i64 %".16", 13
  %".18" = load i32, i32* %"hash"
  %".19" = zext i32 %".18" to i64
  %".20" = shl i64 %".19", 19
  %".21" = or i64 %".17", %".20"
  %".22" = trunc i64 %".21" to i32
  store i32 %".22", i32* %"hash"
  %".24" = load i32, i32* %"hash"
  %".25" = load i8, i8* %"char"
  %".26" = zext i8 %".25" to i32
  %".27" = add i32 %".24", %".26"
  store i32 %".27", i32* %"hash"
  %".29" = load i8, i8* %"cnt"
  %".30" = zext i8 %".29" to i64
  %".31" = add i64 %".30", 1
  %".32" = trunc i64 %".31" to i8
  store i8 %".32", i8* %"cnt"
  %".34" = load i8, i8* %"cnt"
  %".35" = zext i8 %".34" to i32
  %".36" = add i32 %".1", %".35"
  %".37" = inttoptr i32 %".36" to i8*
  %".38" = load i8, i8* %".37"
  store i8 %".38", i8* %"char"
  %".40" = load i8, i8* %"char"
  %".41" = icmp ne i8 %".40", 0
  br i1 %".41", label %"loop_1", label %"loop_after_1"
loop_after_1:
  %".43" = load i32, i32* %"hash"
  ret i32 %".43"
}

define i32 @"compute_module_hash"(i32 %".1")
{
.3:
  %"hash" = alloca i32
  store i32 0, i32* %"hash"
  %"cnt" = alloca i8
  store i8 0, i8* %"cnt"
  %"char" = alloca i16
  %".6" = load i8, i8* %"cnt"
  %".7" = zext i8 %".6" to i32
  %".8" = add i32 %".1", %".7"
  %".9" = inttoptr i32 %".8" to i16*
  %".10" = load i16, i16* %".9"
  store i16 %".10", i16* %"char"
  %".12" = load i16, i16* %"char"
  %".13" = icmp ne i16 %".12", 0
  br i1 %".13", label %"loop_2", label %"loop_after_2"
loop_2:
  %".15" = load i32, i32* %"hash"
  %".16" = zext i32 %".15" to i64
  %".17" = ashr i64 %".16", 13
  %".18" = load i32, i32* %"hash"
  %".19" = zext i32 %".18" to i64
  %".20" = shl i64 %".19", 19
  %".21" = or i64 %".17", %".20"
  %".22" = trunc i64 %".21" to i32
  store i32 %".22", i32* %"hash"
  %".24" = load i32, i32* %"hash"
  %".25" = load i16, i16* %"char"
  %".26" = zext i16 %".25" to i32
  %".27" = add i32 %".24", %".26"
  store i32 %".27", i32* %"hash"
  %".29" = load i8, i8* %"cnt"
  %".30" = zext i8 %".29" to i64
  %".31" = add i64 %".30", 2
  %".32" = trunc i64 %".31" to i8
  store i8 %".32", i8* %"cnt"
  %".34" = load i8, i8* %"cnt"
  %".35" = zext i8 %".34" to i32
  %".36" = add i32 %".1", %".35"
  %".37" = inttoptr i32 %".36" to i16*
  %".38" = load i16, i16* %".37"
  store i16 %".38", i16* %"char"
  %".40" = load i16, i16* %"char"
  %".41" = icmp ne i16 %".40", 0
  br i1 %".41", label %"loop_2", label %"loop_after_2"
loop_after_2:
  %".43" = load i32, i32* %"hash"
  ret i32 %".43"
}

define i32 @"find_module_base"(i32 %".1")
{
.3:
  %"pointer" = alloca i32
  store i32 0, i32* %"pointer"
  %".5" = load i32, i32* %"pointer"
  call void asm sideeffect "", "{eax}"
(i32 %".5")
  call void asm  "mov %fs:48, %eax", ""
()
  %".8" = call i32 asm  "", "={eax}"
()
  store i32 %".8", i32* %"pointer"
  %".10" = load i32, i32* %"pointer"
  %".11" = zext i32 %".10" to i64
  %".12" = add i64 %".11", 12
  %".13" = inttoptr i64 %".12" to i32*
  %".14" = load i32, i32* %".13"
  store i32 %".14", i32* %"pointer"
  %".16" = load i32, i32* %"pointer"
  %".17" = zext i32 %".16" to i64
  %".18" = add i64 %".17", 28
  %".19" = inttoptr i64 %".18" to i32*
  %".20" = load i32, i32* %".19"
  store i32 %".20", i32* %"pointer"
  %"base_address" = alloca i32
  %".22" = load i32, i32* %"pointer"
  %".23" = zext i32 %".22" to i64
  %".24" = add i64 %".23", 8
  %".25" = inttoptr i64 %".24" to i32*
  %".26" = load i32, i32* %".25"
  store i32 %".26", i32* %"base_address"
  %"module_name" = alloca i32
  %".28" = load i32, i32* %"pointer"
  %".29" = zext i32 %".28" to i64
  %".30" = add i64 %".29", 32
  %".31" = inttoptr i64 %".30" to i32*
  %".32" = load i32, i32* %".31"
  store i32 %".32", i32* %"module_name"
  %"guard" = alloca i8
  store i8 0, i8* %"guard"
  %".35" = load i8, i8* %"guard"
  %".36" = icmp eq i8 %".35", 0
  br i1 %".36", label %"loop_3", label %"loop_after_3"
loop_3:
  %".38" = load i32, i32* %"pointer"
  %".39" = inttoptr i32 %".38" to i32*
  %".40" = load i32, i32* %".39"
  store i32 %".40", i32* %"pointer"
  %".42" = load i32, i32* %"pointer"
  %".43" = zext i32 %".42" to i64
  %".44" = add i64 %".43", 8
  %".45" = inttoptr i64 %".44" to i32*
  %".46" = load i32, i32* %".45"
  store i32 %".46", i32* %"base_address"
  %".48" = load i32, i32* %"pointer"
  %".49" = zext i32 %".48" to i64
  %".50" = add i64 %".49", 32
  %".51" = inttoptr i64 %".50" to i32*
  %".52" = load i32, i32* %".51"
  store i32 %".52", i32* %"module_name"
  %".54" = load i32, i32* %"module_name"
  %".55" = icmp eq i32 %".54", 0
  br i1 %".55", label %"loop_3.if", label %"loop_3.else"
loop_after_3:
  ret i32 0
loop_3.if:
  ret i32 0
loop_3.else:
  br label %"loop_3.endif"
loop_3.endif:
  %"computed_hash" = alloca i32
  %".59" = load i32, i32* %"module_name"
  %".60" = call i32 @"compute_module_hash"(i32 %".59")
  store i32 %".60", i32* %"computed_hash"
  %".62" = load i32, i32* %"computed_hash"
  %".63" = icmp eq i32 %".62", %".1"
  br i1 %".63", label %"loop_3.endif.if", label %"loop_3.endif.else"
loop_3.endif.if:
  %".65" = load i32, i32* %"base_address"
  ret i32 %".65"
loop_3.endif.else:
  br label %"loop_3.endif.endif"
loop_3.endif.endif:
  %".68" = load i8, i8* %"guard"
  %".69" = icmp eq i8 %".68", 0
  br i1 %".69", label %"loop_3", label %"loop_after_3"
}

define i32 @"find_function"(i32 %".1", i32 %".2", i8* %".3")
{
.5:
  %"base_address" = alloca i32
  %".6" = call i32 @"find_module_base"(i32 %".2")
  store i32 %".6", i32* %"base_address"
  %".8" = load i32, i32* %"base_address"
  %".9" = icmp eq i32 %".8", 0
  br i1 %".9", label %".5.if", label %".5.else"
.5.if:
  %"load_library" = alloca i32
  %".11" = call i32 @"find_function"(i32 3960360590, i32 1848363543, i8* %".3")
  store i32 %".11", i32* %"load_library"
  %".13" = ptrtoint i8* %".3" to i32
  call void asm sideeffect "", "{ebx}"
(i32 %".13")
  call void asm  "push %ebx", ""
()
  %".16" = load i32, i32* %"load_library"
  call void asm sideeffect "", "{eax}"
(i32 %".16")
  call void asm  "call eax", ""
()
  %".19" = call i32 asm  "", "={eax}"
()
  store i32 %".19", i32* %"base_address"
  br label %".5.endif"
.5.else:
  br label %".5.endif"
.5.endif:
  %"pe_signature" = alloca i32
  %".23" = load i32, i32* %"base_address"
  %".24" = zext i32 %".23" to i64
  %".25" = add i64 %".24", 60
  %".26" = inttoptr i64 %".25" to i32*
  %".27" = load i32, i32* %".26"
  store i32 %".27", i32* %"pe_signature"
  %".29" = load i32, i32* %"pe_signature"
  %".30" = load i32, i32* %"base_address"
  %".31" = add i32 %".29", %".30"
  store i32 %".31", i32* %"pe_signature"
  %"export_table_directory" = alloca i32
  %".33" = load i32, i32* %"pe_signature"
  %".34" = zext i32 %".33" to i64
  %".35" = add i64 %".34", 120
  %".36" = inttoptr i64 %".35" to i32*
  %".37" = load i32, i32* %".36"
  store i32 %".37", i32* %"export_table_directory"
  %".39" = load i32, i32* %"export_table_directory"
  %".40" = load i32, i32* %"base_address"
  %".41" = add i32 %".39", %".40"
  store i32 %".41", i32* %"export_table_directory"
  %"number_of_names" = alloca i32
  %".43" = load i32, i32* %"export_table_directory"
  %".44" = zext i32 %".43" to i64
  %".45" = add i64 %".44", 24
  %".46" = inttoptr i64 %".45" to i32*
  %".47" = load i32, i32* %".46"
  store i32 %".47", i32* %"number_of_names"
  %"address_of_names" = alloca i32
  %".49" = load i32, i32* %"export_table_directory"
  %".50" = zext i32 %".49" to i64
  %".51" = add i64 %".50", 32
  %".52" = inttoptr i64 %".51" to i32*
  %".53" = load i32, i32* %".52"
  store i32 %".53", i32* %"address_of_names"
  %".55" = load i32, i32* %"address_of_names"
  %".56" = load i32, i32* %"base_address"
  %".57" = add i32 %".55", %".56"
  store i32 %".57", i32* %"address_of_names"
  %".59" = load i32, i32* %"number_of_names"
  %".60" = zext i32 %".59" to i64
  %".61" = sub i64 %".60", 1
  %".62" = trunc i64 %".61" to i32
  store i32 %".62", i32* %"number_of_names"
  %".64" = load i32, i32* %"number_of_names"
  %".65" = icmp ugt i32 %".64", 0
  br i1 %".65", label %"loop_4", label %"loop_after_4"
loop_4:
  %"symbol_name" = alloca i32
  %".67" = load i32, i32* %"address_of_names"
  %".68" = load i32, i32* %"number_of_names"
  %".69" = zext i32 %".68" to i64
  %".70" = mul i64 %".69", 4
  %".71" = zext i32 %".67" to i64
  %".72" = add i64 %".71", %".70"
  %".73" = trunc i64 %".72" to i32
  store i32 %".73", i32* %"symbol_name"
  %".75" = load i32, i32* %"base_address"
  %".76" = load i32, i32* %"symbol_name"
  %".77" = inttoptr i32 %".76" to i32*
  %".78" = load i32, i32* %".77"
  %".79" = add i32 %".75", %".78"
  store i32 %".79", i32* %"symbol_name"
  %"computed" = alloca i32
  %".81" = load i32, i32* %"symbol_name"
  %".82" = call i32 @"compute_function_hash"(i32 %".81")
  store i32 %".82", i32* %"computed"
  %".84" = load i32, i32* %"computed"
  %".85" = icmp eq i32 %".84", %".1"
  br i1 %".85", label %"loop_4.if", label %"loop_4.else"
loop_after_4:
  ret i32 0
loop_4.if:
  %"address_of_name_ordinal" = alloca i32
  %".87" = load i32, i32* %"export_table_directory"
  %".88" = zext i32 %".87" to i64
  %".89" = add i64 %".88", 36
  %".90" = inttoptr i64 %".89" to i32*
  %".91" = load i32, i32* %".90"
  store i32 %".91", i32* %"address_of_name_ordinal"
  %".93" = load i32, i32* %"address_of_name_ordinal"
  %".94" = load i32, i32* %"base_address"
  %".95" = add i32 %".93", %".94"
  store i32 %".95", i32* %"address_of_name_ordinal"
  %"ordinal" = alloca i16
  %".97" = load i32, i32* %"address_of_name_ordinal"
  %".98" = load i32, i32* %"number_of_names"
  %".99" = zext i32 %".98" to i64
  %".100" = mul i64 2, %".99"
  %".101" = zext i32 %".97" to i64
  %".102" = add i64 %".101", %".100"
  %".103" = inttoptr i64 %".102" to i16*
  %".104" = load i16, i16* %".103"
  store i16 %".104", i16* %"ordinal"
  %"address_of_functions" = alloca i32
  %".106" = load i32, i32* %"export_table_directory"
  %".107" = zext i32 %".106" to i64
  %".108" = add i64 %".107", 28
  %".109" = inttoptr i64 %".108" to i32*
  %".110" = load i32, i32* %".109"
  store i32 %".110", i32* %"address_of_functions"
  %".112" = load i32, i32* %"address_of_functions"
  %".113" = load i32, i32* %"base_address"
  %".114" = add i32 %".112", %".113"
  store i32 %".114", i32* %"address_of_functions"
  %"function_address" = alloca i32
  %".116" = load i32, i32* %"address_of_functions"
  %".117" = load i16, i16* %"ordinal"
  %".118" = zext i16 %".117" to i64
  %".119" = mul i64 4, %".118"
  %".120" = zext i32 %".116" to i64
  %".121" = add i64 %".120", %".119"
  %".122" = inttoptr i64 %".121" to i32*
  %".123" = load i32, i32* %".122"
  store i32 %".123", i32* %"function_address"
  %".125" = load i32, i32* %"function_address"
  %".126" = load i32, i32* %"base_address"
  %".127" = add i32 %".125", %".126"
  store i32 %".127", i32* %"function_address"
  %".129" = load i32, i32* %"function_address"
  ret i32 %".129"
loop_4.else:
  br label %"loop_4.endif"
loop_4.endif:
  %".132" = load i32, i32* %"number_of_names"
  %".133" = zext i32 %".132" to i64
  %".134" = sub i64 %".133", 1
  %".135" = trunc i64 %".134" to i32
  store i32 %".135", i32* %"number_of_names"
  %".137" = load i32, i32* %"number_of_names"
  %".138" = icmp ugt i32 %".137", 0
  br i1 %".138", label %"loop_4", label %"loop_after_4"
}

define i32 @"main"()
{
.2:
  %".3" = alloca [8 x i8]
  store [8 x i8] zeroinitializer, [8 x i8]* %".3"
  %".5" = getelementptr inbounds [8 x i8], [8 x i8]* %".3", i8 0, i8 0
  store i8 67, i8* %".5"
  %".7" = getelementptr inbounds [8 x i8], [8 x i8]* %".3", i8 0, i8 1
  store i8 97, i8* %".7"
  %".9" = getelementptr inbounds [8 x i8], [8 x i8]* %".3", i8 0, i8 2
  store i8 112, i8* %".9"
  %".11" = getelementptr inbounds [8 x i8], [8 x i8]* %".3", i8 0, i8 3
  store i8 116, i8* %".11"
  %".13" = getelementptr inbounds [8 x i8], [8 x i8]* %".3", i8 0, i8 4
  store i8 105, i8* %".13"
  %".15" = getelementptr inbounds [8 x i8], [8 x i8]* %".3", i8 0, i8 5
  store i8 111, i8* %".15"
  %".17" = getelementptr inbounds [8 x i8], [8 x i8]* %".3", i8 0, i8 6
  store i8 110, i8* %".17"
  %".19" = getelementptr inbounds [8 x i8], [8 x i8]* %".3", i8 0, i8 7
  store i8 0, i8* %".19"
  %".21" = alloca [17 x i8]
  store [17 x i8] zeroinitializer, [17 x i8]* %".21"
  %".23" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 0
  store i8 84, i8* %".23"
  %".25" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 1
  store i8 104, i8* %".25"
  %".27" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 2
  store i8 105, i8* %".27"
  %".29" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 3
  store i8 115, i8* %".29"
  %".31" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 4
  store i8 32, i8* %".31"
  %".33" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 5
  store i8 105, i8* %".33"
  %".35" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 6
  store i8 115, i8* %".35"
  %".37" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 7
  store i8 32, i8* %".37"
  %".39" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 8
  store i8 116, i8* %".39"
  %".41" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 9
  store i8 104, i8* %".41"
  %".43" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 10
  store i8 101, i8* %".43"
  %".45" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 11
  store i8 32, i8* %".45"
  %".47" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 12
  store i8 98, i8* %".47"
  %".49" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 13
  store i8 111, i8* %".49"
  %".51" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 14
  store i8 100, i8* %".51"
  %".53" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 15
  store i8 121, i8* %".53"
  %".55" = getelementptr inbounds [17 x i8], [17 x i8]* %".21", i8 0, i8 16
  store i8 0, i8* %".55"
  %"caption_address" = alloca i8*
  %".57" = bitcast [8 x i8]* %".3" to i8*
  store i8* %".57", i8** %"caption_address"
  store i8* %".57", i8** %"caption_address"
  %"text_address" = alloca i8*
  %".60" = bitcast [17 x i8]* %".21" to i8*
  store i8* %".60", i8** %"text_address"
  store i8* %".60", i8** %"text_address"
  %".63" = alloca [11 x i8]
  store [11 x i8] c"user32.dll\00", [11 x i8]* %".63"
  %".65" = bitcast [11 x i8]* %".63" to i8*
  %".66" = call ccc i32 @"find_function"(i32 3159204520, i32 1412361766, i8* %".65")
  %".67" = load i8*, i8** %"text_address"
  %".68" = load i8*, i8** %"caption_address"
  %".69" = call i32 @"call_MessageBoxA"(i32 0, i8* %".67", i8* %".68", i32 0, i32 %".66")
  ret i32 0
}

define i32 @"call_MessageBoxA"(i32 %".1", i8* %".2", i8* %".3", i32 %".4", i32 %".5")
{
.7:
  call void asm sideeffect "", "{eax}"
(i32 %".5")
  call void asm  "mov %esp,%esi
push 8(%esi)
push 12(%esi)
push 16(%esi)
push 20(%esi)
call eax", ""
()
  ret i32 %".5"
}
