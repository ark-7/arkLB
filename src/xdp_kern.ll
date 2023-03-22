; ModuleID = 'xdp_kern.c'
source_filename = "xdp_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }

@k = dso_local local_unnamed_addr global i32 2, align 4, !dbg !0
@bytes = dso_local local_unnamed_addr global [4 x i8] zeroinitializer, align 1, !dbg !61
@.str = private unnamed_addr constant [23 x i8] c"Heya! XDP buzzLB here!\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"Got non-TCP packet\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"Got TCP packet\00", align 1
@.str.3 = private unnamed_addr constant [14 x i8] c"Source IP: %u\00", align 1
@.str.4 = private unnamed_addr constant [14 x i8] c"Client IP: %u\00", align 1
@.str.5 = private unnamed_addr constant [41 x i8] c"Got packet from client, sending to BE %d\00", align 1
@.str.6 = private unnamed_addr constant [35 x i8] c"Source IP is not equal. Passing...\00", align 1
@.str.7 = private unnamed_addr constant [18 x i8] c"Passing packet...\00", align 1
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !55
@"llvm.ethhdr:0:5$0:0:5" = external global i64, !llvm.preserve.access.index !91 #0
@"llvm.ethhdr:0:12$0:2" = external global i64, !llvm.preserve.access.index !91 #0
@"llvm.iphdr:0:9$0:7" = external global i64, !llvm.preserve.access.index !97 #0
@"llvm.iphdr:0:12$0:9" = external global i64, !llvm.preserve.access.index !97 #0
@"llvm.iphdr:0:16$0:10" = external global i64, !llvm.preserve.access.index !97 #0
@"llvm.ethhdr:0:11$0:1:5" = external global i64, !llvm.preserve.access.index !91 #0
@"llvm.iphdr:0:10$0:8" = external global i64, !llvm.preserve.access.index !97 #0
@"llvm.xdp_md:0:0$0:0" = external global i64, !llvm.preserve.access.index !112 #0
@"llvm.xdp_md:0:4$0:1" = external global i64, !llvm.preserve.access.index !112 #0
@llvm.compiler.used = appending global [2 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.xdp_md*)* @buzz_lb_xdp to i8*)], section "llvm.metadata"

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone willreturn
define dso_local i32 @IP_ADDRESS(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) local_unnamed_addr #1 !dbg !125 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !129, metadata !DIExpression()), !dbg !135
  call void @llvm.dbg.value(metadata i32 %1, metadata !130, metadata !DIExpression()), !dbg !135
  call void @llvm.dbg.value(metadata i32 %2, metadata !131, metadata !DIExpression()), !dbg !135
  call void @llvm.dbg.value(metadata i32 %3, metadata !132, metadata !DIExpression()), !dbg !135
  %5 = shl nsw i32 %0, 24, !dbg !136
  %6 = shl nsw i32 %1, 16, !dbg !137
  %7 = add nsw i32 %6, %5, !dbg !138
  %8 = shl nsw i32 %2, 8, !dbg !139
  %9 = add nsw i32 %7, %8, !dbg !140
  %10 = add nsw i32 %9, %3, !dbg !141
  call void @llvm.dbg.value(metadata i32 %10, metadata !133, metadata !DIExpression()), !dbg !135
  ret i32 %10, !dbg !142
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn writeonly
define dso_local void @print_ip(i32 noundef %0) local_unnamed_addr #2 !dbg !143 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !147, metadata !DIExpression()), !dbg !148
  %2 = trunc i32 %0 to i8, !dbg !149
  store i8 %2, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @bytes, i64 0, i64 0), align 1, !dbg !150, !tbaa !151
  %3 = lshr i32 %0, 8, !dbg !154
  %4 = trunc i32 %3 to i8, !dbg !155
  store i8 %4, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @bytes, i64 0, i64 1), align 1, !dbg !156, !tbaa !151
  %5 = lshr i32 %0, 16, !dbg !157
  %6 = trunc i32 %5 to i8, !dbg !158
  store i8 %6, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @bytes, i64 0, i64 2), align 1, !dbg !159, !tbaa !151
  %7 = lshr i32 %0, 24, !dbg !160
  %8 = trunc i32 %7 to i8, !dbg !161
  store i8 %8, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @bytes, i64 0, i64 3), align 1, !dbg !162, !tbaa !151
  ret void, !dbg !163
}

; Function Attrs: nounwind
define dso_local i32 @buzz_lb_xdp(%struct.xdp_md* noundef readonly %0) #3 section "xdp_lb" !dbg !164 {
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !169, metadata !DIExpression()), !dbg !182
  %2 = load i64, i64* @"llvm.xdp_md:0:0$0:0", align 8
  %3 = bitcast %struct.xdp_md* %0 to i8*
  %4 = getelementptr i8, i8* %3, i64 %2
  %5 = bitcast i8* %4 to i32*
  %6 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 10, i32* %5)
  %7 = load i32, i32* %6, align 4, !dbg !183, !tbaa !184
  %8 = zext i32 %7 to i64, !dbg !187
  %9 = inttoptr i64 %8 to i8*, !dbg !188
  call void @llvm.dbg.value(metadata i8* %9, metadata !170, metadata !DIExpression()), !dbg !182
  %10 = load i64, i64* @"llvm.xdp_md:0:4$0:1", align 8
  %11 = getelementptr i8, i8* %3, i64 %10
  %12 = bitcast i8* %11 to i32*
  %13 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 11, i32* %12)
  %14 = load i32, i32* %13, align 4, !dbg !189, !tbaa !190
  %15 = zext i32 %14 to i64, !dbg !191
  %16 = inttoptr i64 %15 to i8*, !dbg !192
  call void @llvm.dbg.value(metadata i8* %16, metadata !171, metadata !DIExpression()), !dbg !182
  %17 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0), i32 noundef 23) #6, !dbg !193
  call void @llvm.dbg.value(metadata i8* %9, metadata !172, metadata !DIExpression()), !dbg !182
  %18 = getelementptr i8, i8* %9, i64 14, !dbg !194
  %19 = icmp ugt i8* %18, %16, !dbg !196
  br i1 %19, label %128, label %20, !dbg !197

20:                                               ; preds = %1
  %21 = load i64, i64* @"llvm.ethhdr:0:12$0:2", align 8
  %22 = getelementptr i8, i8* %9, i64 %21
  %23 = bitcast i8* %22 to i16*
  %24 = tail call i16* @llvm.bpf.passthrough.p0i16.p0i16(i32 13, i16* %23)
  %25 = load i16, i16* %24, align 2, !dbg !198, !tbaa !200
  %26 = icmp eq i16 %25, 8, !dbg !203
  br i1 %26, label %27, label %128, !dbg !204

27:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i8* %18, metadata !174, metadata !DIExpression()), !dbg !182
  %28 = getelementptr i8, i8* %9, i64 34, !dbg !205
  %29 = icmp ugt i8* %28, %16, !dbg !207
  br i1 %29, label %128, label %30, !dbg !208

30:                                               ; preds = %27
  %31 = load i64, i64* @"llvm.iphdr:0:9$0:7", align 8
  %32 = getelementptr i8, i8* %18, i64 %31
  %33 = tail call i8* @llvm.bpf.passthrough.p0i8.p0i8(i32 2, i8* %32)
  %34 = load i8, i8* %33, align 1, !dbg !209, !tbaa !211
  %35 = icmp eq i8 %34, 6, !dbg !213
  br i1 %35, label %38, label %36, !dbg !214

36:                                               ; preds = %30
  %37 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i64 0, i64 0), i32 noundef 19) #6, !dbg !215
  br label %38, !dbg !215

38:                                               ; preds = %36, %30
  %39 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([15 x i8], [15 x i8]* @.str.2, i64 0, i64 0), i32 noundef 15) #6, !dbg !216
  %40 = load i64, i64* @"llvm.iphdr:0:12$0:9", align 8
  %41 = getelementptr i8, i8* %18, i64 %40
  %42 = bitcast i8* %41 to i32*
  %43 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 3, i32* %42)
  %44 = load i32, i32* %43, align 4, !dbg !217, !tbaa !218
  %45 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([14 x i8], [14 x i8]* @.str.3, i64 0, i64 0), i32 noundef 14, i32 noundef %44) #6, !dbg !219
  call void @llvm.dbg.value(metadata i32 164, metadata !129, metadata !DIExpression()), !dbg !220
  call void @llvm.dbg.value(metadata i32 113, metadata !130, metadata !DIExpression()), !dbg !220
  call void @llvm.dbg.value(metadata i32 193, metadata !131, metadata !DIExpression()), !dbg !220
  call void @llvm.dbg.value(metadata i32 34, metadata !132, metadata !DIExpression()), !dbg !220
  call void @llvm.dbg.value(metadata i32 -1536048862, metadata !133, metadata !DIExpression()), !dbg !220
  call void @llvm.dbg.value(metadata i32 -1536048862, metadata !176, metadata !DIExpression()), !dbg !182
  %46 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([14 x i8], [14 x i8]* @.str.4, i64 0, i64 0), i32 noundef 14, i32 noundef -1536048862) #6, !dbg !222
  %47 = load i64, i64* @"llvm.iphdr:0:12$0:9", align 8
  %48 = getelementptr i8, i8* %18, i64 %47
  %49 = bitcast i8* %48 to i32*
  %50 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 14, i32* %49)
  %51 = load i32, i32* %50, align 4, !dbg !223, !tbaa !218
  call void @llvm.dbg.value(metadata i32 164, metadata !129, metadata !DIExpression()), !dbg !224
  call void @llvm.dbg.value(metadata i32 113, metadata !130, metadata !DIExpression()), !dbg !224
  call void @llvm.dbg.value(metadata i32 193, metadata !131, metadata !DIExpression()), !dbg !224
  call void @llvm.dbg.value(metadata i32 34, metadata !132, metadata !DIExpression()), !dbg !224
  call void @llvm.dbg.value(metadata i32 -1536048862, metadata !133, metadata !DIExpression()), !dbg !224
  %52 = icmp eq i32 %51, -1536048862, !dbg !226
  br i1 %52, label %53, label %79, !dbg !227

53:                                               ; preds = %38
  %54 = load i32, i32* @k, align 4, !dbg !228, !tbaa !230
  %55 = icmp eq i32 %54, 100, !dbg !231
  br i1 %55, label %56, label %57, !dbg !232

56:                                               ; preds = %53
  store i32 2, i32* @k, align 4, !dbg !233, !tbaa !230
  br label %57, !dbg !234

57:                                               ; preds = %56, %53
  %58 = phi i32 [ 2, %56 ], [ %54, %53 ], !dbg !235
  call void @llvm.dbg.value(metadata i32 %58, metadata !179, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !236
  %59 = tail call i64 inttoptr (i64 5 to i64 ()*)() #6, !dbg !237
  %60 = and i64 %59, 1, !dbg !239
  %61 = icmp eq i64 %60, 0, !dbg !239
  br i1 %61, label %65, label %62, !dbg !240

62:                                               ; preds = %57
  %63 = load i32, i32* @k, align 4, !dbg !241, !tbaa !230
  %64 = add nsw i32 %63, 1, !dbg !241
  store i32 %64, i32* @k, align 4, !dbg !241, !tbaa !230
  call void @llvm.dbg.value(metadata i32 %63, metadata !179, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !236
  br label %65, !dbg !243

65:                                               ; preds = %62, %57
  %66 = phi i32 [ %63, %62 ], [ %58, %57 ]
  %67 = trunc i32 %66 to i8, !dbg !236
  call void @llvm.dbg.value(metadata i8 %67, metadata !179, metadata !DIExpression()), !dbg !236
  %68 = shl i32 %66, 24, !dbg !244
  %69 = ashr exact i32 %68, 24, !dbg !244
  %70 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([41 x i8], [41 x i8]* @.str.5, i64 0, i64 0), i32 noundef 41, i32 noundef %69) #6, !dbg !245
  call void @llvm.dbg.value(metadata i32 127, metadata !129, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i32 0, metadata !130, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i32 0, metadata !131, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i32 %69, metadata !132, metadata !DIExpression()), !dbg !246
  %71 = add nsw i32 %69, 2130706432, !dbg !248
  call void @llvm.dbg.value(metadata i32 %71, metadata !133, metadata !DIExpression()), !dbg !246
  %72 = load i64, i64* @"llvm.iphdr:0:16$0:10", align 8
  %73 = getelementptr i8, i8* %18, i64 %72
  %74 = bitcast i8* %73 to i32*
  %75 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 15, i32* %74)
  store i32 %71, i32* %75, align 4, !dbg !249, !tbaa !250
  %76 = load i64, i64* @"llvm.ethhdr:0:5$0:0:5", align 8
  %77 = getelementptr i8, i8* %9, i64 %76
  %78 = tail call i8* @llvm.bpf.passthrough.p0i8.p0i8(i32 4, i8* %77)
  store i8 %67, i8* %78, align 1, !dbg !251, !tbaa !151
  br label %88, !dbg !252

79:                                               ; preds = %38
  call void @llvm.dbg.value(metadata i32 127, metadata !129, metadata !DIExpression()), !dbg !253
  call void @llvm.dbg.value(metadata i32 0, metadata !130, metadata !DIExpression()), !dbg !253
  call void @llvm.dbg.value(metadata i32 0, metadata !131, metadata !DIExpression()), !dbg !253
  call void @llvm.dbg.value(metadata i32 1, metadata !132, metadata !DIExpression()), !dbg !253
  call void @llvm.dbg.value(metadata i32 2130706433, metadata !133, metadata !DIExpression()), !dbg !253
  %80 = load i64, i64* @"llvm.iphdr:0:16$0:10", align 8
  %81 = getelementptr i8, i8* %18, i64 %80
  %82 = bitcast i8* %81 to i32*
  %83 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 5, i32* %82)
  store i32 2130706433, i32* %83, align 4, !dbg !256, !tbaa !250
  %84 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([35 x i8], [35 x i8]* @.str.6, i64 0, i64 0), i32 noundef 39) #6, !dbg !257
  %85 = load i64, i64* @"llvm.ethhdr:0:5$0:0:5", align 8
  %86 = getelementptr i8, i8* %9, i64 %85
  %87 = tail call i8* @llvm.bpf.passthrough.p0i8.p0i8(i32 0, i8* %86)
  store i8 4, i8* %87, align 1, !dbg !258, !tbaa !151
  br label %88

88:                                               ; preds = %79, %65
  call void @llvm.dbg.value(metadata i32 127, metadata !129, metadata !DIExpression()), !dbg !259
  call void @llvm.dbg.value(metadata i32 0, metadata !130, metadata !DIExpression()), !dbg !259
  call void @llvm.dbg.value(metadata i32 0, metadata !131, metadata !DIExpression()), !dbg !259
  call void @llvm.dbg.value(metadata i32 5, metadata !132, metadata !DIExpression()), !dbg !259
  call void @llvm.dbg.value(metadata i32 2130706437, metadata !133, metadata !DIExpression()), !dbg !259
  %89 = load i64, i64* @"llvm.iphdr:0:12$0:9", align 8
  %90 = getelementptr i8, i8* %18, i64 %89
  %91 = bitcast i8* %90 to i32*
  %92 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 6, i32* %91)
  store i32 2130706437, i32* %92, align 4, !dbg !261, !tbaa !218
  %93 = load i64, i64* @"llvm.ethhdr:0:11$0:1:5", align 8
  %94 = getelementptr i8, i8* %9, i64 %93
  %95 = tail call i8* @llvm.bpf.passthrough.p0i8.p0i8(i32 7, i8* %94)
  store i8 5, i8* %95, align 1, !dbg !262, !tbaa !151
  call void @llvm.dbg.value(metadata i8* %18, metadata !263, metadata !DIExpression()) #6, !dbg !269
  %96 = load i64, i64* @"llvm.iphdr:0:10$0:8", align 8
  %97 = getelementptr i8, i8* %18, i64 %96
  %98 = bitcast i8* %97 to i16*
  %99 = tail call i16* @llvm.bpf.passthrough.p0i16.p0i16(i32 16, i16* %98) #6
  store i16 0, i16* %99, align 2, !dbg !271, !tbaa !272
  %100 = bitcast i8* %18 to i32*, !dbg !273
  %101 = tail call i64 inttoptr (i64 28 to i64 (i32*, i32, i32*, i32, i32)*)(i32* noundef null, i32 noundef 0, i32* noundef %100, i32 noundef 20, i32 noundef 0) #6, !dbg !274
  call void @llvm.dbg.value(metadata i64 %101, metadata !268, metadata !DIExpression()) #6, !dbg !269
  call void @llvm.dbg.value(metadata i64 %101, metadata !275, metadata !DIExpression()) #6, !dbg !281
  call void @llvm.dbg.value(metadata i32 0, metadata !280, metadata !DIExpression()) #6, !dbg !281
  call void @llvm.dbg.value(metadata i32 0, metadata !280, metadata !DIExpression()) #6, !dbg !281
  call void @llvm.dbg.value(metadata i64 %101, metadata !275, metadata !DIExpression()) #6, !dbg !281
  %102 = icmp ult i64 %101, 65536, !dbg !283
  %103 = lshr i64 %101, 16, !dbg !288
  %104 = and i64 %101, 65535, !dbg !288
  %105 = add nuw nsw i64 %104, %103, !dbg !288
  %106 = select i1 %102, i64 %101, i64 %105, !dbg !288
  call void @llvm.dbg.value(metadata i64 %106, metadata !275, metadata !DIExpression()) #6, !dbg !281
  call void @llvm.dbg.value(metadata i32 1, metadata !280, metadata !DIExpression()) #6, !dbg !281
  call void @llvm.dbg.value(metadata i32 1, metadata !280, metadata !DIExpression()) #6, !dbg !281
  call void @llvm.dbg.value(metadata i64 %106, metadata !275, metadata !DIExpression()) #6, !dbg !281
  %107 = icmp ult i64 %106, 65536, !dbg !283
  %108 = lshr i64 %106, 16, !dbg !288
  %109 = and i64 %106, 65535, !dbg !288
  %110 = add nuw nsw i64 %109, %108, !dbg !288
  %111 = select i1 %107, i64 %106, i64 %110, !dbg !288
  call void @llvm.dbg.value(metadata i64 %111, metadata !275, metadata !DIExpression()) #6, !dbg !281
  call void @llvm.dbg.value(metadata i32 2, metadata !280, metadata !DIExpression()) #6, !dbg !281
  call void @llvm.dbg.value(metadata i32 2, metadata !280, metadata !DIExpression()) #6, !dbg !281
  call void @llvm.dbg.value(metadata i64 %111, metadata !275, metadata !DIExpression()) #6, !dbg !281
  %112 = icmp ult i64 %111, 65536, !dbg !283
  %113 = lshr i64 %111, 16, !dbg !288
  %114 = and i64 %111, 65535, !dbg !288
  %115 = add nuw nsw i64 %114, %113, !dbg !288
  %116 = select i1 %112, i64 %111, i64 %115, !dbg !288
  call void @llvm.dbg.value(metadata i64 %116, metadata !275, metadata !DIExpression()) #6, !dbg !281
  call void @llvm.dbg.value(metadata i32 3, metadata !280, metadata !DIExpression()) #6, !dbg !281
  call void @llvm.dbg.value(metadata i32 3, metadata !280, metadata !DIExpression()) #6, !dbg !281
  call void @llvm.dbg.value(metadata i64 %116, metadata !275, metadata !DIExpression()) #6, !dbg !281
  %117 = icmp ult i64 %116, 65536, !dbg !283
  %118 = lshr i64 %116, 16, !dbg !288
  %119 = select i1 %117, i64 65536, i64 %118, !dbg !288
  %120 = add nuw nsw i64 %119, %116, !dbg !288
  call void @llvm.dbg.value(metadata i64 undef, metadata !275, metadata !DIExpression()) #6, !dbg !281
  call void @llvm.dbg.value(metadata i32 4, metadata !280, metadata !DIExpression()) #6, !dbg !281
  %121 = trunc i64 %120 to i16, !dbg !289
  %122 = xor i16 %121, -1, !dbg !289
  %123 = load i64, i64* @"llvm.iphdr:0:10$0:8", align 8
  %124 = getelementptr i8, i8* %18, i64 %123
  %125 = bitcast i8* %124 to i16*
  %126 = tail call i16* @llvm.bpf.passthrough.p0i16.p0i16(i32 8, i16* %125)
  store i16 %122, i16* %126, align 2, !dbg !290, !tbaa !272
  %127 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([18 x i8], [18 x i8]* @.str.7, i64 0, i64 0), i32 noundef 18) #6, !dbg !291
  br label %128

128:                                              ; preds = %88, %27, %20, %1
  %129 = phi i32 [ 0, %1 ], [ 2, %20 ], [ 3, %88 ], [ 0, %27 ], !dbg !182
  ret i32 %129, !dbg !292
}

; Function Attrs: nofree nosync nounwind readnone
declare i8* @llvm.bpf.passthrough.p0i8.p0i8(i32, i8*) #4

; Function Attrs: nofree nosync nounwind readnone
declare i16* @llvm.bpf.passthrough.p0i16.p0i16(i32, i16*) #4

; Function Attrs: nofree nosync nounwind readnone
declare i32* @llvm.bpf.passthrough.p0i32.p0i32(i32, i32*) #4

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #5

attributes #0 = { "btf_ama" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind readnone willreturn "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn writeonly "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #3 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #4 = { nofree nosync nounwind readnone }
attributes #5 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!120, !121, !122, !123}
!llvm.ident = !{!124}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "k", scope: !2, file: !3, line: 8, type: !90, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !44, globals: !54, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_kern.c", directory: "/home/ubuntu/arkLB/src", checksumkind: CSK_MD5, checksum: "f50c41b77ee919d94fc1a783abb793e6")
!4 = !{!5, !14}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 42776, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "./vmlinux.h", directory: "/home/ubuntu/arkLB/src", checksumkind: CSK_MD5, checksum: "11eb692ee35903a9cd527ec4f7485b7b")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2)
!12 = !DIEnumerator(name: "XDP_TX", value: 3)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 11396, baseType: !7, size: 32, elements: !15)
!15 = !{!16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43}
!16 = !DIEnumerator(name: "IPPROTO_IP", value: 0)
!17 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1)
!18 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2)
!19 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4)
!20 = !DIEnumerator(name: "IPPROTO_TCP", value: 6)
!21 = !DIEnumerator(name: "IPPROTO_EGP", value: 8)
!22 = !DIEnumerator(name: "IPPROTO_PUP", value: 12)
!23 = !DIEnumerator(name: "IPPROTO_UDP", value: 17)
!24 = !DIEnumerator(name: "IPPROTO_IDP", value: 22)
!25 = !DIEnumerator(name: "IPPROTO_TP", value: 29)
!26 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33)
!27 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41)
!28 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46)
!29 = !DIEnumerator(name: "IPPROTO_GRE", value: 47)
!30 = !DIEnumerator(name: "IPPROTO_ESP", value: 50)
!31 = !DIEnumerator(name: "IPPROTO_AH", value: 51)
!32 = !DIEnumerator(name: "IPPROTO_MTP", value: 92)
!33 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94)
!34 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98)
!35 = !DIEnumerator(name: "IPPROTO_PIM", value: 103)
!36 = !DIEnumerator(name: "IPPROTO_COMP", value: 108)
!37 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132)
!38 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136)
!39 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137)
!40 = !DIEnumerator(name: "IPPROTO_ETHERNET", value: 143)
!41 = !DIEnumerator(name: "IPPROTO_RAW", value: 255)
!42 = !DIEnumerator(name: "IPPROTO_MPTCP", value: 262)
!43 = !DIEnumerator(name: "IPPROTO_MAX", value: 263)
!44 = !{!45, !46, !47, !49, !50}
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!46 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!47 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !6, line: 10, baseType: !48)
!48 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!50 = !DICompositeType(tag: DW_TAG_array_type, baseType: !51, size: 48, elements: !52)
!51 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!52 = !{!53}
!53 = !DISubrange(count: 6)
!54 = !{!0, !55, !61, !64, !73, !80}
!55 = !DIGlobalVariableExpression(var: !56, expr: !DIExpression())
!56 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 107, type: !57, isLocal: false, isDefinition: true)
!57 = !DICompositeType(tag: DW_TAG_array_type, baseType: !58, size: 32, elements: !59)
!58 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!59 = !{!60}
!60 = !DISubrange(count: 4)
!61 = !DIGlobalVariableExpression(var: !62, expr: !DIExpression())
!62 = distinct !DIGlobalVariable(name: "bytes", scope: !2, file: !3, line: 12, type: !63, isLocal: false, isDefinition: true)
!63 = !DICompositeType(tag: DW_TAG_array_type, baseType: !51, size: 32, elements: !59)
!64 = !DIGlobalVariableExpression(var: !65, expr: !DIExpression())
!65 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !66, line: 177, type: !67, isLocal: true, isDefinition: true)
!66 = !DIFile(filename: "./../libbpf/src/bpf_helper_defs.h", directory: "/home/ubuntu/arkLB/src", checksumkind: CSK_MD5, checksum: "2d210aba22162d34a56b8d1dc5e331a2")
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !68, size: 64)
!68 = !DISubroutineType(types: !69)
!69 = !{!46, !70, !72, null}
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!71 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !58)
!72 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !6, line: 12, baseType: !7)
!73 = !DIGlobalVariableExpression(var: !74, expr: !DIExpression())
!74 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !66, line: 114, type: !75, isLocal: true, isDefinition: true)
!75 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !76, size: 64)
!76 = !DISubroutineType(types: !77)
!77 = !{!78}
!78 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !6, line: 16, baseType: !79)
!79 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!80 = !DIGlobalVariableExpression(var: !81, expr: !DIExpression())
!81 = distinct !DIGlobalVariable(name: "bpf_csum_diff", scope: !2, file: !66, line: 794, type: !82, isLocal: true, isDefinition: true)
!82 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !83, size: 64)
!83 = !DISubroutineType(types: !84)
!84 = !{!85, !87, !72, !87, !72, !89}
!85 = !DIDerivedType(tag: DW_TAG_typedef, name: "__s64", file: !6, line: 14, baseType: !86)
!86 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!87 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !88, size: 64)
!88 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !6, line: 7174, baseType: !72)
!89 = !DIDerivedType(tag: DW_TAG_typedef, name: "__wsum", file: !6, line: 7176, baseType: !72)
!90 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!91 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !6, line: 63925, size: 112, elements: !92)
!92 = !{!93, !94, !95}
!93 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !91, file: !6, line: 63926, baseType: !50, size: 48)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !91, file: !6, line: 63927, baseType: !50, size: 48, offset: 48)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !91, file: !6, line: 63928, baseType: !96, size: 16, offset: 96)
!96 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !6, line: 7170, baseType: !47)
!97 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !6, line: 66181, size: 160, elements: !98)
!98 = !{!99, !101, !102, !103, !104, !105, !106, !107, !108, !110, !111}
!99 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !97, file: !6, line: 66182, baseType: !100, size: 4, flags: DIFlagBitField, extraData: i64 0)
!100 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !6, line: 8, baseType: !51)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !97, file: !6, line: 66183, baseType: !100, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !97, file: !6, line: 66184, baseType: !100, size: 8, offset: 8)
!103 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !97, file: !6, line: 66185, baseType: !96, size: 16, offset: 16)
!104 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !97, file: !6, line: 66186, baseType: !96, size: 16, offset: 32)
!105 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !97, file: !6, line: 66187, baseType: !96, size: 16, offset: 48)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !97, file: !6, line: 66188, baseType: !100, size: 8, offset: 64)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !97, file: !6, line: 66189, baseType: !100, size: 8, offset: 72)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !97, file: !6, line: 66190, baseType: !109, size: 16, offset: 80)
!109 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !6, line: 65086, baseType: !47)
!110 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !97, file: !6, line: 66191, baseType: !88, size: 32, offset: 96)
!111 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !97, file: !6, line: 66192, baseType: !88, size: 32, offset: 128)
!112 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 46155, size: 192, elements: !113)
!113 = !{!114, !115, !116, !117, !118, !119}
!114 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !112, file: !6, line: 46156, baseType: !72, size: 32)
!115 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !112, file: !6, line: 46157, baseType: !72, size: 32, offset: 32)
!116 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !112, file: !6, line: 46158, baseType: !72, size: 32, offset: 64)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !112, file: !6, line: 46159, baseType: !72, size: 32, offset: 96)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !112, file: !6, line: 46160, baseType: !72, size: 32, offset: 128)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !112, file: !6, line: 46161, baseType: !72, size: 32, offset: 160)
!120 = !{i32 7, !"Dwarf Version", i32 5}
!121 = !{i32 2, !"Debug Info Version", i32 3}
!122 = !{i32 1, !"wchar_size", i32 4}
!123 = !{i32 7, !"frame-pointer", i32 2}
!124 = !{!"Ubuntu clang version 14.0.0-1ubuntu1"}
!125 = distinct !DISubprogram(name: "IP_ADDRESS", scope: !3, file: !3, line: 14, type: !126, scopeLine: 14, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !128)
!126 = !DISubroutineType(types: !127)
!127 = !{!7, !90, !90, !90, !90}
!128 = !{!129, !130, !131, !132, !133}
!129 = !DILocalVariable(name: "w", arg: 1, scope: !125, file: !3, line: 14, type: !90)
!130 = !DILocalVariable(name: "x", arg: 2, scope: !125, file: !3, line: 14, type: !90)
!131 = !DILocalVariable(name: "y", arg: 3, scope: !125, file: !3, line: 14, type: !90)
!132 = !DILocalVariable(name: "z", arg: 4, scope: !125, file: !3, line: 14, type: !90)
!133 = !DILocalVariable(name: "res", scope: !125, file: !3, line: 15, type: !134)
!134 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint", file: !6, line: 25240, baseType: !7)
!135 = !DILocation(line: 0, scope: !125)
!136 = !DILocation(line: 15, column: 29, scope: !125)
!137 = !DILocation(line: 15, column: 43, scope: !125)
!138 = !DILocation(line: 15, column: 33, scope: !125)
!139 = !DILocation(line: 15, column: 53, scope: !125)
!140 = !DILocation(line: 15, column: 47, scope: !125)
!141 = !DILocation(line: 15, column: 57, scope: !125)
!142 = !DILocation(line: 16, column: 5, scope: !125)
!143 = distinct !DISubprogram(name: "print_ip", scope: !3, file: !3, line: 19, type: !144, scopeLine: 20, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !146)
!144 = !DISubroutineType(types: !145)
!145 = !{null, !7}
!146 = !{!147}
!147 = !DILocalVariable(name: "ip", arg: 1, scope: !143, file: !3, line: 19, type: !7)
!148 = !DILocation(line: 0, scope: !143)
!149 = !DILocation(line: 21, column: 16, scope: !143)
!150 = !DILocation(line: 21, column: 14, scope: !143)
!151 = !{!152, !152, i64 0}
!152 = !{!"omnipotent char", !153, i64 0}
!153 = !{!"Simple C/C++ TBAA"}
!154 = !DILocation(line: 22, column: 20, scope: !143)
!155 = !DILocation(line: 22, column: 16, scope: !143)
!156 = !DILocation(line: 22, column: 14, scope: !143)
!157 = !DILocation(line: 23, column: 20, scope: !143)
!158 = !DILocation(line: 23, column: 16, scope: !143)
!159 = !DILocation(line: 23, column: 14, scope: !143)
!160 = !DILocation(line: 24, column: 20, scope: !143)
!161 = !DILocation(line: 24, column: 16, scope: !143)
!162 = !DILocation(line: 24, column: 14, scope: !143)
!163 = !DILocation(line: 26, column: 1, scope: !143)
!164 = distinct !DISubprogram(name: "buzz_lb_xdp", scope: !3, file: !3, line: 55, type: !165, scopeLine: 55, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !168)
!165 = !DISubroutineType(types: !166)
!166 = !{!90, !167}
!167 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 64)
!168 = !{!169, !170, !171, !172, !174, !176, !179}
!169 = !DILocalVariable(name: "ctx", arg: 1, scope: !164, file: !3, line: 55, type: !167)
!170 = !DILocalVariable(name: "data", scope: !164, file: !3, line: 56, type: !45)
!171 = !DILocalVariable(name: "data_end", scope: !164, file: !3, line: 57, type: !45)
!172 = !DILocalVariable(name: "eth", scope: !164, file: !3, line: 61, type: !173)
!173 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !91, size: 64)
!174 = !DILocalVariable(name: "iph", scope: !164, file: !3, line: 68, type: !175)
!175 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !97, size: 64)
!176 = !DILocalVariable(name: "ip", scope: !164, file: !3, line: 78, type: !177)
!177 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !6, line: 1883, baseType: !178)
!178 = !DIDerivedType(tag: DW_TAG_typedef, name: "u32", file: !6, line: 409, baseType: !72)
!179 = !DILocalVariable(name: "be", scope: !180, file: !3, line: 84, type: !58)
!180 = distinct !DILexicalBlock(scope: !181, file: !3, line: 81, column: 5)
!181 = distinct !DILexicalBlock(scope: !164, file: !3, line: 80, column: 9)
!182 = !DILocation(line: 0, scope: !164)
!183 = !DILocation(line: 56, column: 37, scope: !164)
!184 = !{!185, !186, i64 0}
!185 = !{!"xdp_md", !186, i64 0, !186, i64 4, !186, i64 8, !186, i64 12, !186, i64 16, !186, i64 20}
!186 = !{!"int", !152, i64 0}
!187 = !DILocation(line: 56, column: 26, scope: !164)
!188 = !DILocation(line: 56, column: 18, scope: !164)
!189 = !DILocation(line: 57, column: 41, scope: !164)
!190 = !{!185, !186, i64 4}
!191 = !DILocation(line: 57, column: 30, scope: !164)
!192 = !DILocation(line: 57, column: 22, scope: !164)
!193 = !DILocation(line: 59, column: 5, scope: !164)
!194 = !DILocation(line: 62, column: 14, scope: !195)
!195 = distinct !DILexicalBlock(scope: !164, file: !3, line: 62, column: 9)
!196 = !DILocation(line: 62, column: 38, scope: !195)
!197 = !DILocation(line: 62, column: 9, scope: !164)
!198 = !DILocation(line: 65, column: 9, scope: !199)
!199 = distinct !DILexicalBlock(scope: !164, file: !3, line: 65, column: 9)
!200 = !{!201, !202, i64 12}
!201 = !{!"ethhdr", !152, i64 0, !152, i64 6, !202, i64 12}
!202 = !{!"short", !152, i64 0}
!203 = !DILocation(line: 65, column: 33, scope: !199)
!204 = !DILocation(line: 65, column: 9, scope: !164)
!205 = !DILocation(line: 69, column: 38, scope: !206)
!206 = distinct !DILexicalBlock(scope: !164, file: !3, line: 69, column: 9)
!207 = !DILocation(line: 69, column: 61, scope: !206)
!208 = !DILocation(line: 69, column: 9, scope: !164)
!209 = !DILocation(line: 72, column: 14, scope: !210)
!210 = distinct !DILexicalBlock(scope: !164, file: !3, line: 72, column: 9)
!211 = !{!212, !152, i64 9}
!212 = !{!"iphdr", !152, i64 0, !152, i64 0, !152, i64 1, !202, i64 2, !202, i64 4, !202, i64 6, !152, i64 8, !152, i64 9, !202, i64 10, !186, i64 12, !186, i64 16}
!213 = !DILocation(line: 72, column: 23, scope: !210)
!214 = !DILocation(line: 72, column: 9, scope: !164)
!215 = !DILocation(line: 73, column: 9, scope: !210)
!216 = !DILocation(line: 75, column: 5, scope: !164)
!217 = !DILocation(line: 76, column: 69, scope: !164)
!218 = !{!212, !186, i64 12}
!219 = !DILocation(line: 76, column: 5, scope: !164)
!220 = !DILocation(line: 0, scope: !125, inlinedAt: !221)
!221 = distinct !DILocation(line: 78, column: 19, scope: !164)
!222 = !DILocation(line: 79, column: 5, scope: !164)
!223 = !DILocation(line: 80, column: 14, scope: !181)
!224 = !DILocation(line: 0, scope: !125, inlinedAt: !225)
!225 = distinct !DILocation(line: 80, column: 23, scope: !181)
!226 = !DILocation(line: 80, column: 20, scope: !181)
!227 = !DILocation(line: 80, column: 9, scope: !164)
!228 = !DILocation(line: 82, column: 12, scope: !229)
!229 = distinct !DILexicalBlock(scope: !180, file: !3, line: 82, column: 12)
!230 = !{!186, !186, i64 0}
!231 = !DILocation(line: 82, column: 14, scope: !229)
!232 = !DILocation(line: 82, column: 12, scope: !180)
!233 = !DILocation(line: 83, column: 15, scope: !229)
!234 = !DILocation(line: 83, column: 13, scope: !229)
!235 = !DILocation(line: 84, column: 19, scope: !180)
!236 = !DILocation(line: 0, scope: !180)
!237 = !DILocation(line: 86, column: 12, scope: !238)
!238 = distinct !DILexicalBlock(scope: !180, file: !3, line: 86, column: 12)
!239 = !DILocation(line: 86, column: 31, scope: !238)
!240 = !DILocation(line: 86, column: 12, scope: !180)
!241 = !DILocation(line: 87, column: 19, scope: !242)
!242 = distinct !DILexicalBlock(scope: !238, file: !3, line: 86, column: 36)
!243 = !DILocation(line: 88, column: 9, scope: !242)
!244 = !DILocation(line: 89, column: 122, scope: !180)
!245 = !DILocation(line: 89, column: 9, scope: !180)
!246 = !DILocation(line: 0, scope: !125, inlinedAt: !247)
!247 = distinct !DILocation(line: 90, column: 22, scope: !180)
!248 = !DILocation(line: 15, column: 57, scope: !125, inlinedAt: !247)
!249 = !DILocation(line: 90, column: 20, scope: !180)
!250 = !{!212, !186, i64 16}
!251 = !DILocation(line: 91, column: 24, scope: !180)
!252 = !DILocation(line: 92, column: 5, scope: !180)
!253 = !DILocation(line: 0, scope: !125, inlinedAt: !254)
!254 = distinct !DILocation(line: 95, column: 22, scope: !255)
!255 = distinct !DILexicalBlock(scope: !181, file: !3, line: 94, column: 5)
!256 = !DILocation(line: 95, column: 20, scope: !255)
!257 = !DILocation(line: 96, column: 9, scope: !255)
!258 = !DILocation(line: 97, column: 24, scope: !255)
!259 = !DILocation(line: 0, scope: !125, inlinedAt: !260)
!260 = distinct !DILocation(line: 99, column: 18, scope: !164)
!261 = !DILocation(line: 99, column: 16, scope: !164)
!262 = !DILocation(line: 100, column: 22, scope: !164)
!263 = !DILocalVariable(name: "iph", arg: 1, scope: !264, file: !3, line: 42, type: !175)
!264 = distinct !DISubprogram(name: "iph_csum", scope: !3, file: !3, line: 42, type: !265, scopeLine: 43, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !267)
!265 = !DISubroutineType(types: !266)
!266 = !{!47, !175}
!267 = !{!263, !268}
!268 = !DILocalVariable(name: "csum", scope: !264, file: !3, line: 45, type: !79)
!269 = !DILocation(line: 0, scope: !264, inlinedAt: !270)
!270 = distinct !DILocation(line: 102, column: 18, scope: !164)
!271 = !DILocation(line: 44, column: 16, scope: !264, inlinedAt: !270)
!272 = !{!212, !202, i64 10}
!273 = !DILocation(line: 45, column: 51, scope: !264, inlinedAt: !270)
!274 = !DILocation(line: 45, column: 31, scope: !264, inlinedAt: !270)
!275 = !DILocalVariable(name: "csum", arg: 1, scope: !276, file: !3, line: 29, type: !78)
!276 = distinct !DISubprogram(name: "csum_fold_helper", scope: !3, file: !3, line: 29, type: !277, scopeLine: 30, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !279)
!277 = !DISubroutineType(types: !278)
!278 = !{!47, !78}
!279 = !{!275, !280}
!280 = !DILocalVariable(name: "i", scope: !276, file: !3, line: 31, type: !90)
!281 = !DILocation(line: 0, scope: !276, inlinedAt: !282)
!282 = distinct !DILocation(line: 46, column: 12, scope: !264, inlinedAt: !270)
!283 = !DILocation(line: 35, column: 18, scope: !284, inlinedAt: !282)
!284 = distinct !DILexicalBlock(scope: !285, file: !3, line: 35, column: 13)
!285 = distinct !DILexicalBlock(scope: !286, file: !3, line: 34, column: 5)
!286 = distinct !DILexicalBlock(scope: !287, file: !3, line: 33, column: 5)
!287 = distinct !DILexicalBlock(scope: !276, file: !3, line: 33, column: 5)
!288 = !DILocation(line: 35, column: 13, scope: !285, inlinedAt: !282)
!289 = !DILocation(line: 38, column: 12, scope: !276, inlinedAt: !282)
!290 = !DILocation(line: 102, column: 16, scope: !164)
!291 = !DILocation(line: 103, column: 5, scope: !164)
!292 = !DILocation(line: 105, column: 1, scope: !164)
