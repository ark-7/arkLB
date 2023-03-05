; ModuleID = 'xdp_buzz_kern.c'
source_filename = "xdp_buzz_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [4 x i32]*, [16 x i32]*, i32*, i32* }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.S = type { i64 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@xdp_buzz_hello.____fmt = internal constant [13 x i8] c"Hey it's liz\00", align 1, !dbg !0
@my_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !83
@xdp_buzz_hello.____fmt.1 = internal constant [30 x i8] c"perf_event_output failed: %d\0A\00", align 1, !dbg !66
@xdp_buzz_hello.____fmt.2 = internal constant [23 x i8] c"Got TCP packet from %x\00", align 1, !dbg !73
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !78
@llvm.compiler.used = appending global [3 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon* @my_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_buzz_hello to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_buzz_hello(%struct.xdp_md* noundef %0) #0 section "xdp_buzz" !dbg !2 {
  %2 = alloca %struct.S, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !118, metadata !DIExpression()), !dbg !168
  %3 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !169
  %4 = load i32, i32* %3, align 4, !dbg !169, !tbaa !170
  %5 = zext i32 %4 to i64, !dbg !175
  %6 = inttoptr i64 %5 to i8*, !dbg !176
  call void @llvm.dbg.value(metadata i8* %6, metadata !119, metadata !DIExpression()), !dbg !168
  %7 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !177
  %8 = load i32, i32* %7, align 4, !dbg !177, !tbaa !178
  %9 = zext i32 %8 to i64, !dbg !179
  %10 = inttoptr i64 %9 to i8*, !dbg !180
  call void @llvm.dbg.value(metadata i8* %10, metadata !120, metadata !DIExpression()), !dbg !168
  %11 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([13 x i8], [13 x i8]* @xdp_buzz_hello.____fmt, i64 0, i64 0), i32 noundef 13) #4, !dbg !181
  %12 = bitcast %struct.S* %2 to i8*, !dbg !183
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %12) #4, !dbg !183
  call void @llvm.dbg.declare(metadata %struct.S* %2, metadata !121, metadata !DIExpression()), !dbg !184
  %13 = tail call i64 inttoptr (i64 5 to i64 ()*)() #4, !dbg !185
  %14 = getelementptr inbounds %struct.S, %struct.S* %2, i64 0, i32 0, !dbg !186
  store i64 %13, i64* %14, align 8, !dbg !187, !tbaa !188
  %15 = bitcast %struct.xdp_md* %0 to i8*, !dbg !191
  %16 = call i64 inttoptr (i64 25 to i64 (i8*, i8*, i64, i8*, i64)*)(i8* noundef %15, i8* noundef bitcast (%struct.anon* @my_map to i8*), i64 noundef 0, i8* noundef nonnull %12, i64 noundef 8) #4, !dbg !192
  %17 = trunc i64 %16 to i32, !dbg !192
  call void @llvm.dbg.value(metadata i32 %17, metadata !126, metadata !DIExpression()), !dbg !168
  %18 = icmp eq i32 %17, 0, !dbg !193
  br i1 %18, label %21, label %19, !dbg !195

19:                                               ; preds = %1
  %20 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([30 x i8], [30 x i8]* @xdp_buzz_hello.____fmt.1, i64 0, i64 0), i32 noundef 30, i32 noundef %17) #4, !dbg !196
  br label %21, !dbg !198

21:                                               ; preds = %19, %1
  call void @llvm.dbg.value(metadata i8* %6, metadata !127, metadata !DIExpression()), !dbg !168
  %22 = getelementptr i8, i8* %6, i64 14, !dbg !199
  %23 = icmp ugt i8* %22, %10, !dbg !201
  br i1 %23, label %41, label %24, !dbg !202

24:                                               ; preds = %21
  %25 = inttoptr i64 %5 to %struct.ethhdr*, !dbg !203
  call void @llvm.dbg.value(metadata %struct.ethhdr* %25, metadata !127, metadata !DIExpression()), !dbg !168
  %26 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %25, i64 0, i32 2, !dbg !204
  %27 = load i16, i16* %26, align 1, !dbg !204, !tbaa !206
  %28 = icmp eq i16 %27, 8, !dbg !209
  br i1 %28, label %29, label %41, !dbg !210

29:                                               ; preds = %24
  call void @llvm.dbg.value(metadata i8* %22, metadata !141, metadata !DIExpression()), !dbg !168
  %30 = getelementptr i8, i8* %6, i64 34, !dbg !211
  %31 = icmp ugt i8* %30, %10, !dbg !213
  br i1 %31, label %41, label %32, !dbg !214

32:                                               ; preds = %29
  %33 = getelementptr i8, i8* %6, i64 23, !dbg !215
  %34 = load i8, i8* %33, align 1, !dbg !215, !tbaa !217
  %35 = icmp eq i8 %34, 6, !dbg !219
  br i1 %35, label %36, label %41, !dbg !220

36:                                               ; preds = %32
  %37 = getelementptr i8, i8* %6, i64 26, !dbg !221
  %38 = bitcast i8* %37 to i32*, !dbg !221
  %39 = load i32, i32* %38, align 4, !dbg !221, !tbaa !223
  %40 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([23 x i8], [23 x i8]* @xdp_buzz_hello.____fmt.2, i64 0, i64 0), i32 noundef 23, i32 noundef %39) #4, !dbg !221
  br label %41, !dbg !224

41:                                               ; preds = %36, %29, %32, %24, %21
  %42 = phi i32 [ 0, %21 ], [ 2, %24 ], [ 2, %36 ], [ 0, %29 ], [ 2, %32 ], !dbg !168
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %12) #4, !dbg !225
  ret i32 %42, !dbg !225
}

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

attributes #0 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #3 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!20}
!llvm.module.flags = !{!163, !164, !165, !166}
!llvm.ident = !{!167}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "____fmt", scope: !2, file: !3, line: 19, type: !160, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "xdp_buzz_hello", scope: !3, file: !3, line: 14, type: !4, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !117)
!3 = !DIFile(filename: "xdp_buzz_kern.c", directory: "/media/aadhitya/DATA/XCodes/buzzLB", checksumkind: CSK_MD5, checksum: "62286462a4b2a88ce0fed62a93ef644f")
!4 = !DISubroutineType(types: !5)
!5 = !{!6, !7}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!8 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !9, line: 5442, size: 192, elements: !10)
!9 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "", checksumkind: CSK_MD5, checksum: "5ad8bc925dae1ec87bbb04b3148b183b")
!10 = !{!11, !15, !16, !17, !18, !19}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !8, file: !9, line: 5443, baseType: !12, size: 32)
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !13, line: 27, baseType: !14)
!13 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!14 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !8, file: !9, line: 5444, baseType: !12, size: 32, offset: 32)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !8, file: !9, line: 5445, baseType: !12, size: 32, offset: 64)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !8, file: !9, line: 5447, baseType: !12, size: 32, offset: 96)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !8, file: !9, line: 5448, baseType: !12, size: 32, offset: 128)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !8, file: !9, line: 5450, baseType: !12, size: 32, offset: 160)
!20 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !21, retainedTypes: !60, globals: !65, splitDebugInlining: false, nameTableKind: None)
!21 = !{!22, !29}
!22 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !9, line: 5431, baseType: !14, size: 32, elements: !23)
!23 = !{!24, !25, !26, !27, !28}
!24 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!25 = !DIEnumerator(name: "XDP_DROP", value: 1)
!26 = !DIEnumerator(name: "XDP_PASS", value: 2)
!27 = !DIEnumerator(name: "XDP_TX", value: 3)
!28 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!29 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !30, line: 28, baseType: !14, size: 32, elements: !31)
!30 = !DIFile(filename: "/usr/include/linux/in.h", directory: "", checksumkind: CSK_MD5, checksum: "9a7f04155c254fef1b7ada5eb82c984c")
!31 = !{!32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43, !44, !45, !46, !47, !48, !49, !50, !51, !52, !53, !54, !55, !56, !57, !58, !59}
!32 = !DIEnumerator(name: "IPPROTO_IP", value: 0)
!33 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1)
!34 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2)
!35 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4)
!36 = !DIEnumerator(name: "IPPROTO_TCP", value: 6)
!37 = !DIEnumerator(name: "IPPROTO_EGP", value: 8)
!38 = !DIEnumerator(name: "IPPROTO_PUP", value: 12)
!39 = !DIEnumerator(name: "IPPROTO_UDP", value: 17)
!40 = !DIEnumerator(name: "IPPROTO_IDP", value: 22)
!41 = !DIEnumerator(name: "IPPROTO_TP", value: 29)
!42 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33)
!43 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41)
!44 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46)
!45 = !DIEnumerator(name: "IPPROTO_GRE", value: 47)
!46 = !DIEnumerator(name: "IPPROTO_ESP", value: 50)
!47 = !DIEnumerator(name: "IPPROTO_AH", value: 51)
!48 = !DIEnumerator(name: "IPPROTO_MTP", value: 92)
!49 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94)
!50 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98)
!51 = !DIEnumerator(name: "IPPROTO_PIM", value: 103)
!52 = !DIEnumerator(name: "IPPROTO_COMP", value: 108)
!53 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132)
!54 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136)
!55 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137)
!56 = !DIEnumerator(name: "IPPROTO_ETHERNET", value: 143)
!57 = !DIEnumerator(name: "IPPROTO_RAW", value: 255)
!58 = !DIEnumerator(name: "IPPROTO_MPTCP", value: 262)
!59 = !DIEnumerator(name: "IPPROTO_MAX", value: 263)
!60 = !{!61, !62, !63}
!61 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!62 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!63 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !13, line: 24, baseType: !64)
!64 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!65 = !{!0, !66, !73, !78, !83, !98, !105, !112}
!66 = !DIGlobalVariableExpression(var: !67, expr: !DIExpression())
!67 = distinct !DIGlobalVariable(name: "____fmt", scope: !2, file: !3, line: 26, type: !68, isLocal: true, isDefinition: true)
!68 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 240, elements: !71)
!69 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !70)
!70 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!71 = !{!72}
!72 = !DISubrange(count: 30)
!73 = !DIGlobalVariableExpression(var: !74, expr: !DIExpression())
!74 = distinct !DIGlobalVariable(name: "____fmt", scope: !2, file: !3, line: 42, type: !75, isLocal: true, isDefinition: true)
!75 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 184, elements: !76)
!76 = !{!77}
!77 = !DISubrange(count: 23)
!78 = !DIGlobalVariableExpression(var: !79, expr: !DIExpression())
!79 = distinct !DIGlobalVariable(name: "_license", scope: !20, file: !3, line: 47, type: !80, isLocal: false, isDefinition: true)
!80 = !DICompositeType(tag: DW_TAG_array_type, baseType: !70, size: 32, elements: !81)
!81 = !{!82}
!82 = !DISubrange(count: 4)
!83 = !DIGlobalVariableExpression(var: !84, expr: !DIExpression())
!84 = distinct !DIGlobalVariable(name: "my_map", scope: !20, file: !3, line: 11, type: !85, isLocal: false, isDefinition: true)
!85 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 6, size: 256, elements: !86)
!86 = !{!87, !90, !95, !97}
!87 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !85, file: !3, line: 7, baseType: !88, size: 64)
!88 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !89, size: 64)
!89 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 128, elements: !81)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !85, file: !3, line: 8, baseType: !91, size: 64, offset: 64)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !92, size: 64)
!92 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 512, elements: !93)
!93 = !{!94}
!94 = !DISubrange(count: 16)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !85, file: !3, line: 9, baseType: !96, size: 64, offset: 128)
!96 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !85, file: !3, line: 10, baseType: !96, size: 64, offset: 192)
!98 = !DIGlobalVariableExpression(var: !99, expr: !DIExpression())
!99 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !20, file: !100, line: 177, type: !101, isLocal: true, isDefinition: true)
!100 = !DIFile(filename: "libbpf/src/bpf_helper_defs.h", directory: "/media/aadhitya/DATA/XCodes/buzzLB", checksumkind: CSK_MD5, checksum: "b2cd2382f6759099a049f8375ad49987")
!101 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !102, size: 64)
!102 = !DISubroutineType(types: !103)
!103 = !{!62, !104, !12, null}
!104 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !69, size: 64)
!105 = !DIGlobalVariableExpression(var: !106, expr: !DIExpression())
!106 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !20, file: !100, line: 114, type: !107, isLocal: true, isDefinition: true)
!107 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !108, size: 64)
!108 = !DISubroutineType(types: !109)
!109 = !{!110}
!110 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !13, line: 31, baseType: !111)
!111 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!112 = !DIGlobalVariableExpression(var: !113, expr: !DIExpression())
!113 = distinct !DIGlobalVariable(name: "bpf_perf_event_output", scope: !20, file: !100, line: 696, type: !114, isLocal: true, isDefinition: true)
!114 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !115, size: 64)
!115 = !DISubroutineType(types: !116)
!116 = !{!62, !61, !61, !110, !61, !110}
!117 = !{!118, !119, !120, !121, !126, !127, !141}
!118 = !DILocalVariable(name: "ctx", arg: 1, scope: !2, file: !3, line: 14, type: !7)
!119 = !DILocalVariable(name: "data", scope: !2, file: !3, line: 16, type: !61)
!120 = !DILocalVariable(name: "data_end", scope: !2, file: !3, line: 17, type: !61)
!121 = !DILocalVariable(name: "trace", scope: !2, file: !3, line: 21, type: !122)
!122 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S", file: !123, line: 1, size: 64, elements: !124)
!123 = !DIFile(filename: "./xdp_buzz.h", directory: "/media/aadhitya/DATA/XCodes/buzzLB", checksumkind: CSK_MD5, checksum: "de24cd6f9720d5a9009d49116f5da71b")
!124 = !{!125}
!125 = !DIDerivedType(tag: DW_TAG_member, name: "time", scope: !122, file: !123, line: 3, baseType: !111, size: 64)
!126 = !DILocalVariable(name: "ret", scope: !2, file: !3, line: 22, type: !6)
!127 = !DILocalVariable(name: "eth", scope: !2, file: !3, line: 28, type: !128)
!128 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 64)
!129 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !130, line: 168, size: 112, elements: !131)
!130 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "ab0320da726e75d904811ce344979934")
!131 = !{!132, !137, !138}
!132 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !129, file: !130, line: 169, baseType: !133, size: 48)
!133 = !DICompositeType(tag: DW_TAG_array_type, baseType: !134, size: 48, elements: !135)
!134 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!135 = !{!136}
!136 = !DISubrange(count: 6)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !129, file: !130, line: 170, baseType: !133, size: 48, offset: 48)
!138 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !129, file: !130, line: 171, baseType: !139, size: 16, offset: 96)
!139 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !140, line: 25, baseType: !63)
!140 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "52ec79a38e49ac7d1dc9e146ba88a7b1")
!141 = !DILocalVariable(name: "iph", scope: !2, file: !3, line: 35, type: !142)
!142 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !143, size: 64)
!143 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !144, line: 86, size: 160, elements: !145)
!144 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "", checksumkind: CSK_MD5, checksum: "8776158f5e307e9a8189f0dae4b43df4")
!145 = !{!146, !148, !149, !150, !151, !152, !153, !154, !155, !157, !159}
!146 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !143, file: !144, line: 88, baseType: !147, size: 4, flags: DIFlagBitField, extraData: i64 0)
!147 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !13, line: 21, baseType: !134)
!148 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !143, file: !144, line: 89, baseType: !147, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!149 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !143, file: !144, line: 96, baseType: !147, size: 8, offset: 8)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !143, file: !144, line: 97, baseType: !139, size: 16, offset: 16)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !143, file: !144, line: 98, baseType: !139, size: 16, offset: 32)
!152 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !143, file: !144, line: 99, baseType: !139, size: 16, offset: 48)
!153 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !143, file: !144, line: 100, baseType: !147, size: 8, offset: 64)
!154 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !143, file: !144, line: 101, baseType: !147, size: 8, offset: 72)
!155 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !143, file: !144, line: 102, baseType: !156, size: 16, offset: 80)
!156 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !140, line: 31, baseType: !63)
!157 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !143, file: !144, line: 103, baseType: !158, size: 32, offset: 96)
!158 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !140, line: 27, baseType: !12)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !143, file: !144, line: 104, baseType: !158, size: 32, offset: 128)
!160 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 104, elements: !161)
!161 = !{!162}
!162 = !DISubrange(count: 13)
!163 = !{i32 7, !"Dwarf Version", i32 5}
!164 = !{i32 2, !"Debug Info Version", i32 3}
!165 = !{i32 1, !"wchar_size", i32 4}
!166 = !{i32 7, !"frame-pointer", i32 2}
!167 = !{!"Ubuntu clang version 14.0.0-1ubuntu1"}
!168 = !DILocation(line: 0, scope: !2)
!169 = !DILocation(line: 16, column: 37, scope: !2)
!170 = !{!171, !172, i64 0}
!171 = !{!"xdp_md", !172, i64 0, !172, i64 4, !172, i64 8, !172, i64 12, !172, i64 16, !172, i64 20}
!172 = !{!"int", !173, i64 0}
!173 = !{!"omnipotent char", !174, i64 0}
!174 = !{!"Simple C/C++ TBAA"}
!175 = !DILocation(line: 16, column: 26, scope: !2)
!176 = !DILocation(line: 16, column: 18, scope: !2)
!177 = !DILocation(line: 17, column: 41, scope: !2)
!178 = !{!171, !172, i64 4}
!179 = !DILocation(line: 17, column: 30, scope: !2)
!180 = !DILocation(line: 17, column: 22, scope: !2)
!181 = !DILocation(line: 19, column: 5, scope: !182)
!182 = distinct !DILexicalBlock(scope: !2, file: !3, line: 19, column: 5)
!183 = !DILocation(line: 21, column: 5, scope: !2)
!184 = !DILocation(line: 21, column: 14, scope: !2)
!185 = !DILocation(line: 23, column: 18, scope: !2)
!186 = !DILocation(line: 23, column: 11, scope: !2)
!187 = !DILocation(line: 23, column: 16, scope: !2)
!188 = !{!189, !190, i64 0}
!189 = !{!"S", !190, i64 0}
!190 = !{!"long long", !173, i64 0}
!191 = !DILocation(line: 24, column: 33, scope: !2)
!192 = !DILocation(line: 24, column: 11, scope: !2)
!193 = !DILocation(line: 25, column: 9, scope: !194)
!194 = distinct !DILexicalBlock(scope: !2, file: !3, line: 25, column: 9)
!195 = !DILocation(line: 25, column: 9, scope: !2)
!196 = !DILocation(line: 26, column: 9, scope: !197)
!197 = distinct !DILexicalBlock(scope: !194, file: !3, line: 26, column: 9)
!198 = !DILocation(line: 26, column: 9, scope: !194)
!199 = !DILocation(line: 29, column: 14, scope: !200)
!200 = distinct !DILexicalBlock(scope: !2, file: !3, line: 29, column: 9)
!201 = !DILocation(line: 29, column: 38, scope: !200)
!202 = !DILocation(line: 29, column: 9, scope: !2)
!203 = !DILocation(line: 28, column: 26, scope: !2)
!204 = !DILocation(line: 32, column: 9, scope: !205)
!205 = distinct !DILexicalBlock(scope: !2, file: !3, line: 32, column: 9)
!206 = !{!207, !208, i64 12}
!207 = !{!"ethhdr", !173, i64 0, !173, i64 6, !208, i64 12}
!208 = !{!"short", !173, i64 0}
!209 = !DILocation(line: 32, column: 33, scope: !205)
!210 = !DILocation(line: 32, column: 9, scope: !2)
!211 = !DILocation(line: 36, column: 38, scope: !212)
!212 = distinct !DILexicalBlock(scope: !2, file: !3, line: 36, column: 9)
!213 = !DILocation(line: 36, column: 61, scope: !212)
!214 = !DILocation(line: 36, column: 9, scope: !2)
!215 = !DILocation(line: 39, column: 14, scope: !216)
!216 = distinct !DILexicalBlock(scope: !2, file: !3, line: 39, column: 9)
!217 = !{!218, !173, i64 9}
!218 = !{!"iphdr", !173, i64 0, !173, i64 0, !173, i64 1, !208, i64 2, !208, i64 4, !208, i64 6, !173, i64 8, !173, i64 9, !208, i64 10, !172, i64 12, !172, i64 16}
!219 = !DILocation(line: 39, column: 23, scope: !216)
!220 = !DILocation(line: 39, column: 9, scope: !2)
!221 = !DILocation(line: 42, column: 5, scope: !222)
!222 = distinct !DILexicalBlock(scope: !2, file: !3, line: 42, column: 5)
!223 = !{!218, !172, i64 12}
!224 = !DILocation(line: 44, column: 5, scope: !2)
!225 = !DILocation(line: 45, column: 1, scope: !2)
