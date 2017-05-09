	.nolist
			|--------------------------------------------------------------------------
			| jump.inc
			|
			|--------------------------------------------------------------------------
			| System\SystemMgr.rh
sysFileCSystem	=	0x70737973
sysFileCGraffiti	=	0x67726166
sysFileCSystemPatch	=	0x70746368
sysFileCCalculator	=	0x63616c63
sysFileCSecurity	=	0x73656372
sysFileCPreferences	=	0x70726566
sysFileCAddress	=	0x61646472
sysFileCToDo	=	0x746f646f
sysFileCDatebook	=	0x64617465
sysFileCMemo	=	0x6d656d6f
sysFileCSync	=	0x73796e63
sysFileCMemory	=	0x6d656d72
sysFileCMail	=	0x6d61696c
sysFileCExpense	=	0x65787073
sysFileCLauncher	=	0x6c6e6368
sysFileCGraffitiDemo	=	0x6764656d
sysFileCMailDemo	=	0x6d64656d
sysFileCFirstApp	=	sysFileCPreferences
sysFileCDefaultApp	=	sysFileCPreferences
sysFileCDefaultButton1App	=	sysFileCDatebook
sysFileCDefaultButton2App	=	sysFileCAddress
sysFileCDefaultButton3App	=	sysFileCToDo
sysFileCDefaultButton4App	=	sysFileCMemo
sysFileCDefaultCalcButtonApp	=	sysFileCCalculator
sysFileCDefaultCradleApp	=	sysFileCSync
sysFileCDefaultModemApp	=	sysFileCSync
sysFileCNullApp	=	0x30303030
sysFileCDigitizer	=	0x64696769
sysFileCGeneral	=	0x676e726c
sysFileCFormats	=	0x66726d74
sysFileCShortCuts	=	0x73686374
sysFileCButtons	=	0x6274746e
sysFileCOwner	=	0x6f776e72
sysFileCModemPanel	=	0x6d6f646d
sysFileCDialPanel	=	0x6469616c
sysFileCNetworkPanel	=	0x6e657477
sysFileCPADHtal	=	0x68706164
sysFileCTCPHtal	=	0x68746370
sysFileCMineHunt	=	0x6d696e65
sysFileCPuzzle15	=	0x70757a6c
sysFileCOpenLibInfo	=	0x6f6c6269
sysFileTLibrary	=	0x6c696272
sysFileCNet	=	0x6e65746c
sysFileCIrLib	=	0x69726461
sysFileCSerialHwrMgr	=	0x7368776d
sysFileCSerialWrapper	=	0x73777270
sysFileCIrSerialWrapper	=	0x69777270
sysFileTUartPlugIn	=	0x73647276
sysFileCUart328	=	0x75333238
sysFileCUart650	=	0x75363530
sysFileTSystem	=	0x72737263
sysFileTSystemPatch	=	0x70746368
sysFileTKernel	=	0x6b726e6c
sysFileTUIAppShell	=	0x75697368
sysFileTExtension	=	0x6578746e
sysFileTApplication	=	0x6170706c
sysFileTPanel	=	0x70616e6c
sysFileTSavedPreferences	=	0x73707266
sysFileTPreferences	=	0x70726566
sysFileTMidi	=	0x736d6672
sysFileTGraffitiMacros	=	0x6d616372
sysFileTHtalLib	=	0x6874616c
sysFileTExgLib	=	0x6578676c
sysFileTFileStream	=	0x7374726d
sysFileTTemp	=	0x74656d70
sysResTBootCode	=	0x626f6f74
sysResIDBootReset	=	10000
sysResIDBootInitCode	=	10001
sysResIDBootSysCodeStart	=	10100
sysResIDBootSysCodeMin	=	10102
sysResIDBootUICodeStart	=	10200
sysResIDBootUICodeMin	=	10203
sysResTAppPrefs	=	0x70726566
sysResTAppCode	=	0x636f6465
sysResTAppGData	=	0x64617461
sysResTExtensionCode	=	0x6578746e
sysResTFeatures	=	0x66656174
sysResIDFeatures	=	10000
sysResTCountries	=	0x636e7479
sysResIDCountries	=	10000
sysResTLibrary	=	0x6c696272
sysResIDLibrarySerMgr328	=	10000
sysResIDLibrarySerMgr681	=	10001
sysResIDLibraryRMPPlugIn	=	10002
sysResTGrfTemplate	=	0x746d706c
sysResIDGrfTemplate	=	10000
sysResTGrfDictionary	=	0x64696374
sysResIDGrfDictionary	=	10000
sysResIDGrfDefaultMacros	=	10000
sysResTDefaultDB	=	0x64666c74
sysResIDDefaultDB	=	1
sysResTErrStrings	=	0x745354
sysResIDErrStrings	=	10000
sysResTSysPref	=	sysFileCSystem
sysResIDSysPrefMain	=	0
sysResIDSysPrefPassword	=	1
sysResIDSysPrefFindStr	=	2
sysResIDSysPrefCalibration	=	3
sysResIDDlkUserInfo	=	4
sysResIDDlkLocalPC	=	5
sysResIDDlkCondFilterTab	=	6
sysResIDModemMgrPref	=	7
sysResIDDlkLocalPCAddr	=	8
sysResIDDlkLocalPCMask	=	9
sysResTInBox	=	0x69626f78
sysResTOutBox	=	0x6f626f78
			| system/systraps.h
sysTrapBase	=	0xA000
sysTrapMemInit	=	40960
sysTrapMemInitHeapTable	=	40961
sysTrapMemStoreInit	=	40962
sysTrapMemCardFormat	=	40963
sysTrapMemCardInfo	=	40964
sysTrapMemStoreInfo	=	40965
sysTrapMemStoreSetInfo	=	40966
sysTrapMemNumHeaps	=	40967
sysTrapMemNumRAMHeaps	=	40968
sysTrapMemHeapID	=	40969
sysTrapMemHeapPtr	=	40970
sysTrapMemHeapFreeBytes	=	40971
sysTrapMemHeapSize	=	40972
sysTrapMemHeapFlags	=	40973
sysTrapMemHeapCompact	=	40974
sysTrapMemHeapInit	=	40975
sysTrapMemHeapFreeByOwnerID	=	40976
sysTrapMemChunkNew	=	40977
sysTrapMemChunkFree	=	40978
sysTrapMemPtrNew	=	40979
sysTrapMemPtrFree	=	sysTrapMemChunkFree
sysTrapMemPtrRecoverHandle	=	40980
sysTrapMemPtrFlags	=	40981
sysTrapMemPtrSize	=	40982
sysTrapMemPtrOwner	=	40983
sysTrapMemPtrHeapID	=	40984
sysTrapMemPtrCardNo	=	40985
sysTrapMemPtrToLocalID	=	40986
sysTrapMemPtrSetOwner	=	40987
sysTrapMemPtrResize	=	40988
sysTrapMemPtrResetLock	=	40989
sysTrapMemHandleNew	=	40990
sysTrapMemHandleLockCount	=	40991
sysTrapMemHandleToLocalID	=	40992
sysTrapMemHandleLock	=	40993
sysTrapMemHandleUnlock	=	40994
sysTrapMemLocalIDToGlobal	=	40995
sysTrapMemLocalIDKind	=	40996
sysTrapMemLocalIDToPtr	=	40997
sysTrapMemMove	=	40998
sysTrapMemSet	=	40999
sysTrapMemStoreSearch	=	41000
sysTrapMemPtrDataStorage	=	41001
sysTrapMemKernelInit	=	41002
sysTrapMemHandleFree	=	41003
sysTrapMemHandleFlags	=	41004
sysTrapMemHandleSize	=	41005
sysTrapMemHandleOwner	=	41006
sysTrapMemHandleHeapID	=	41007
sysTrapMemHandleDataStorage	=	41008
sysTrapMemHandleCardNo	=	41009
sysTrapMemHandleSetOwner	=	41010
sysTrapMemHandleResize	=	41011
sysTrapMemHandleResetLock	=	41012
sysTrapMemPtrUnlock	=	41013
sysTrapMemLocalIDToLockedPtr	=	41014
sysTrapMemSetDebugMode	=	41015
sysTrapMemHeapScramble	=	41016
sysTrapMemHeapCheck	=	41017
sysTrapMemNumCards	=	41018
sysTrapMemDebugMode	=	41019
sysTrapMemSemaphoreReserve	=	41020
sysTrapMemSemaphoreRelease	=	41021
sysTrapMemHeapDynamic	=	41022
sysTrapMemNVParams	=	41023
sysTrapDmInit	=	41024
sysTrapDmCreateDatabase	=	41025
sysTrapDmDeleteDatabase	=	41026
sysTrapDmNumDatabases	=	41027
sysTrapDmGetDatabase	=	41028
sysTrapDmFindDatabase	=	41029
sysTrapDmDatabaseInfo	=	41030
sysTrapDmSetDatabaseInfo	=	41031
sysTrapDmDatabaseSize	=	41032
sysTrapDmOpenDatabase	=	41033
sysTrapDmCloseDatabase	=	41034
sysTrapDmNextOpenDatabase	=	41035
sysTrapDmOpenDatabaseInfo	=	41036
sysTrapDmResetRecordStates	=	41037
sysTrapDmGetLastErr	=	41038
sysTrapDmNumRecords	=	41039
sysTrapDmRecordInfo	=	41040
sysTrapDmSetRecordInfo	=	41041
sysTrapDmAttachRecord	=	41042
sysTrapDmDetachRecord	=	41043
sysTrapDmMoveRecord	=	41044
sysTrapDmNewRecord	=	41045
sysTrapDmRemoveRecord	=	41046
sysTrapDmDeleteRecord	=	41047
sysTrapDmArchiveRecord	=	41048
sysTrapDmNewHandle	=	41049
sysTrapDmRemoveSecretRecords	=	41050
sysTrapDmQueryRecord	=	41051
sysTrapDmGetRecord	=	41052
sysTrapDmResizeRecord	=	41053
sysTrapDmReleaseRecord	=	41054
sysTrapDmGetResource	=	41055
sysTrapDmGet1Resource	=	41056
sysTrapDmReleaseResource	=	41057
sysTrapDmResizeResource	=	41058
sysTrapDmNextOpenResDatabase	=	41059
sysTrapDmFindResourceType	=	41060
sysTrapDmFindResource	=	41061
sysTrapDmSearchResource	=	41062
sysTrapDmNumResources	=	41063
sysTrapDmResourceInfo	=	41064
sysTrapDmSetResourceInfo	=	41065
sysTrapDmAttachResource	=	41066
sysTrapDmDetachResource	=	41067
sysTrapDmNewResource	=	41068
sysTrapDmRemoveResource	=	41069
sysTrapDmGetResourceIndex	=	41070
sysTrapDmQuickSort	=	41071
sysTrapDmQueryNextInCategory	=	41072
sysTrapDmNumRecordsInCategory	=	41073
sysTrapDmPositionInCategory	=	41074
sysTrapDmSeekRecordInCategory	=	41075
sysTrapDmMoveCategory	=	41076
sysTrapDmOpenDatabaseByTypeCreator	=	41077
sysTrapDmWrite	=	41078
sysTrapDmStrCopy	=	41079
sysTrapDmGetNextDatabaseByTypeCreator	=	41080
sysTrapDmWriteCheck	=	41081
sysTrapDmMoveOpenDBContext	=	41082
sysTrapDmFindRecordByID	=	41083
sysTrapDmGetAppInfoID	=	41084
sysTrapDmFindSortPositionV10	=	41085
sysTrapDmSet	=	41086
sysTrapDmCreateDatabaseFromImage	=	41087
sysTrapDbgSrcMessage	=	41088
sysTrapDbgMessage	=	41089
sysTrapDbgGetMessage	=	41090
sysTrapDbgCommSettings	=	41091
sysTrapErrDisplayFileLineMsg	=	41092
sysTrapErrSetJump	=	41093
sysTrapErrLongJump	=	41094
sysTrapErrThrow	=	41095
sysTrapErrExceptionList	=	41096
sysTrapSysBroadcastActionCode	=	41097
sysTrapSysUnimplemented	=	41098
sysTrapSysColdBoot	=	41099
sysTrapSysReset	=	41100
sysTrapSysDoze	=	41101
sysTrapSysAppLaunch	=	41102
sysTrapSysAppStartup	=	41103
sysTrapSysAppExit	=	41104
sysTrapSysSetA5	=	41105
sysTrapSysSetTrapAddress	=	41106
sysTrapSysGetTrapAddress	=	41107
sysTrapSysTranslateKernelErr	=	41108
sysTrapSysSemaphoreCreate	=	41109
sysTrapSysSemaphoreDelete	=	41110
sysTrapSysSemaphoreWait	=	41111
sysTrapSysSemaphoreSignal	=	41112
sysTrapSysTimerCreate	=	41113
sysTrapSysTimerWrite	=	41114
sysTrapSysTaskCreate	=	41115
sysTrapSysTaskDelete	=	41116
sysTrapSysTaskTrigger	=	41117
sysTrapSysTaskID	=	41118
sysTrapSysTaskUserInfoPtr	=	41119
sysTrapSysTaskDelay	=	41120
sysTrapSysTaskSetTermProc	=	41121
sysTrapSysUILaunch	=	41122
sysTrapSysNewOwnerID	=	41123
sysTrapSysSemaphoreSet	=	41124
sysTrapSysDisableInts	=	41125
sysTrapSysRestoreStatus	=	41126
sysTrapSysUIAppSwitch	=	41127
sysTrapSysCurAppInfoPV20	=	41128
sysTrapSysHandleEvent	=	41129
sysTrapSysInit	=	41130
sysTrapSysQSort	=	41131
sysTrapSysCurAppDatabase	=	41132
sysTrapSysFatalAlert	=	41133
sysTrapSysResSemaphoreCreate	=	41134
sysTrapSysResSemaphoreDelete	=	41135
sysTrapSysResSemaphoreReserve	=	41136
sysTrapSysResSemaphoreRelease	=	41137
sysTrapSysSleep	=	41138
sysTrapSysKeyboardDialogV10	=	41139
sysTrapSysAppLauncherDialog	=	41140
sysTrapSysSetPerformance	=	41141
sysTrapSysBatteryInfoV20	=	41142
sysTrapSysLibInstall	=	41143
sysTrapSysLibRemove	=	41144
sysTrapSysLibTblEntry	=	41145
sysTrapSysLibFind	=	41146
sysTrapSysBatteryDialog	=	41147
sysTrapSysCopyStringResource	=	41148
sysTrapSysKernelInfo	=	41149
sysTrapSysLaunchConsole	=	41150
sysTrapSysTimerDelete	=	41151
sysTrapSysSetAutoOffTime	=	41152
sysTrapSysFormPointerArrayToStrings	=	41153
sysTrapSysRandom	=	41154
sysTrapSysTaskSwitching	=	41155
sysTrapSysTimerRead	=	41156
sysTrapStrCopy	=	41157
sysTrapStrCat	=	41158
sysTrapStrLen	=	41159
sysTrapStrCompare	=	41160
sysTrapStrIToA	=	41161
sysTrapStrCaselessCompare	=	41162
sysTrapStrIToH	=	41163
sysTrapStrChr	=	41164
sysTrapStrStr	=	41165
sysTrapStrAToI	=	41166
sysTrapStrToLower	=	41167
sysTrapSerReceiveISP	=	41168
sysTrapSlkOpen	=	41169
sysTrapSlkClose	=	41170
sysTrapSlkOpenSocket	=	41171
sysTrapSlkCloseSocket	=	41172
sysTrapSlkSocketRefNum	=	41173
sysTrapSlkSocketSetTimeout	=	41174
sysTrapSlkFlushSocket	=	41175
sysTrapSlkSetSocketListener	=	41176
sysTrapSlkSendPacket	=	41177
sysTrapSlkReceivePacket	=	41178
sysTrapSlkSysPktDefaultResponse	=	41179
sysTrapSlkProcessRPC	=	41180
sysTrapConPutS	=	41181
sysTrapConGetS	=	41182
sysTrapFplInit	=	41183
sysTrapFplFree	=	41184
sysTrapFplFToA	=	41185
sysTrapFplAToF	=	41186
sysTrapFplBase10Info	=	41187
sysTrapFplLongToFloat	=	41188
sysTrapFplFloatToLong	=	41189
sysTrapFplFloatToULong	=	41190
sysTrapFplMul	=	41191
sysTrapFplAdd	=	41192
sysTrapFplSub	=	41193
sysTrapFplDiv	=	41194
sysTrapScrInit	=	41195
sysTrapScrCopyRectangle	=	41196
sysTrapScrDrawChars	=	41197
sysTrapScrLineRoutine	=	41198
sysTrapScrRectangleRoutine	=	41199
sysTrapScrScreenInfo	=	41200
sysTrapScrDrawNotify	=	41201
sysTrapScrSendUpdateArea	=	41202
sysTrapScrCompressScanLine	=	41203
sysTrapScrDeCompressScanLine	=	41204
sysTrapTimGetSeconds	=	41205
sysTrapTimSetSeconds	=	41206
sysTrapTimGetTicks	=	41207
sysTrapTimInit	=	41208
sysTrapTimSetAlarm	=	41209
sysTrapTimGetAlarm	=	41210
sysTrapTimHandleInterrupt	=	41211
sysTrapTimSecondsToDateTime	=	41212
sysTrapTimDateTimeToSeconds	=	41213
sysTrapTimAdjust	=	41214
sysTrapTimSleep	=	41215
sysTrapTimWake	=	41216
sysTrapCategoryCreateListV10	=	41217
sysTrapCategoryFreeListV10	=	41218
sysTrapCategoryFind	=	41219
sysTrapCategoryGetName	=	41220
sysTrapCategoryEditV10	=	41221
sysTrapCategorySelectV10	=	41222
sysTrapCategoryGetNext	=	41223
sysTrapCategorySetTriggerLabel	=	41224
sysTrapCategoryTruncateName	=	41225
sysTrapClipboardAddItem	=	41226
sysTrapClipboardCheckIfItemExist	=	41227
sysTrapClipboardGetItem	=	41228
sysTrapCtlDrawControl	=	41229
sysTrapCtlEraseControl	=	41230
sysTrapCtlHideControl	=	41231
sysTrapCtlShowControl	=	41232
sysTrapCtlGetValue	=	41233
sysTrapCtlSetValue	=	41234
sysTrapCtlGetLabel	=	41235
sysTrapCtlSetLabel	=	41236
sysTrapCtlHandleEvent	=	41237
sysTrapCtlHitControl	=	41238
sysTrapCtlSetEnabled	=	41239
sysTrapCtlSetUsable	=	41240
sysTrapCtlEnabled	=	41241
sysTrapEvtInitialize	=	41242
sysTrapEvtAddEventToQueue	=	41243
sysTrapEvtCopyEvent	=	41244
sysTrapEvtGetEvent	=	41245
sysTrapEvtGetPen	=	41246
sysTrapEvtSysInit	=	41247
sysTrapEvtGetSysEvent	=	41248
sysTrapEvtProcessSoftKeyStroke	=	41249
sysTrapEvtGetPenBtnList	=	41250
sysTrapEvtSetPenQueuePtr	=	41251
sysTrapEvtPenQueueSize	=	41252
sysTrapEvtFlushPenQueue	=	41253
sysTrapEvtEnqueuePenPoint	=	41254
sysTrapEvtDequeuePenStrokeInfo	=	41255
sysTrapEvtDequeuePenPoint	=	41256
sysTrapEvtFlushNextPenStroke	=	41257
sysTrapEvtSetKeyQueuePtr	=	41258
sysTrapEvtKeyQueueSize	=	41259
sysTrapEvtFlushKeyQueue	=	41260
sysTrapEvtEnqueueKey	=	41261
sysTrapEvtDequeueKeyEvent	=	41262
sysTrapEvtWakeup	=	41263
sysTrapEvtResetAutoOffTimer	=	41264
sysTrapEvtKeyQueueEmpty	=	41265
sysTrapEvtEnableGraffiti	=	41266
sysTrapFldCopy	=	41267
sysTrapFldCut	=	41268
sysTrapFldDrawField	=	41269
sysTrapFldEraseField	=	41270
sysTrapFldFreeMemory	=	41271
sysTrapFldGetBounds	=	41272
sysTrapFldGetTextPtr	=	41273
sysTrapFldGetSelection	=	41274
sysTrapFldHandleEvent	=	41275
sysTrapFldPaste	=	41276
sysTrapFldRecalculateField	=	41277
sysTrapFldSetBounds	=	41278
sysTrapFldSetText	=	41279
sysTrapFldGetFont	=	41280
sysTrapFldSetFont	=	41281
sysTrapFldSetSelection	=	41282
sysTrapFldGrabFocus	=	41283
sysTrapFldReleaseFocus	=	41284
sysTrapFldGetInsPtPosition	=	41285
sysTrapFldSetInsPtPosition	=	41286
sysTrapFldSetScrollPosition	=	41287
sysTrapFldGetScrollPosition	=	41288
sysTrapFldGetTextHeight	=	41289
sysTrapFldGetTextAllocatedSize	=	41290
sysTrapFldGetTextLength	=	41291
sysTrapFldScrollField	=	41292
sysTrapFldScrollable	=	41293
sysTrapFldGetVisibleLines	=	41294
sysTrapFldGetAttributes	=	41295
sysTrapFldSetAttributes	=	41296
sysTrapFldSendChangeNotification	=	41297
sysTrapFldCalcFieldHeight	=	41298
sysTrapFldGetTextHandle	=	41299
sysTrapFldCompactText	=	41300
sysTrapFldDirty	=	41301
sysTrapFldWordWrap	=	41302
sysTrapFldSetTextAllocatedSize	=	41303
sysTrapFldSetTextHandle	=	41304
sysTrapFldSetTextPtr	=	41305
sysTrapFldGetMaxChars	=	41306
sysTrapFldSetMaxChars	=	41307
sysTrapFldSetUsable	=	41308
sysTrapFldInsert	=	41309
sysTrapFldDelete	=	41310
sysTrapFldUndo	=	41311
sysTrapFldSetDirty	=	41312
sysTrapFldSendHeightChangeNotification	=	41313
sysTrapFldMakeFullyVisible	=	41314
sysTrapFntGetFont	=	41315
sysTrapFntSetFont	=	41316
sysTrapFntGetFontPtr	=	41317
sysTrapFntBaseLine	=	41318
sysTrapFntCharHeight	=	41319
sysTrapFntLineHeight	=	41320
sysTrapFntAverageCharWidth	=	41321
sysTrapFntCharWidth	=	41322
sysTrapFntCharsWidth	=	41323
sysTrapFntDescenderHeight	=	41324
sysTrapFntCharsInWidth	=	41325
sysTrapFntLineWidth	=	41326
sysTrapFrmInitForm	=	41327
sysTrapFrmDeleteForm	=	41328
sysTrapFrmDrawForm	=	41329
sysTrapFrmEraseForm	=	41330
sysTrapFrmGetActiveForm	=	41331
sysTrapFrmSetActiveForm	=	41332
sysTrapFrmGetActiveFormID	=	41333
sysTrapFrmGetUserModifiedState	=	41334
sysTrapFrmSetNotUserModified	=	41335
sysTrapFrmGetFocus	=	41336
sysTrapFrmSetFocus	=	41337
sysTrapFrmHandleEvent	=	41338
sysTrapFrmGetFormBounds	=	41339
sysTrapFrmGetWindowHandle	=	41340
sysTrapFrmGetFormId	=	41341
sysTrapFrmGetFormPtr	=	41342
sysTrapFrmGetNumberOfObjects	=	41343
sysTrapFrmGetObjectIndex	=	41344
sysTrapFrmGetObjectId	=	41345
sysTrapFrmGetObjectType	=	41346
sysTrapFrmGetObjectPtr	=	41347
sysTrapFrmHideObject	=	41348
sysTrapFrmShowObject	=	41349
sysTrapFrmGetObjectPosition	=	41350
sysTrapFrmSetObjectPosition	=	41351
sysTrapFrmGetControlValue	=	41352
sysTrapFrmSetControlValue	=	41353
sysTrapFrmGetControlGroupSelection	=	41354
sysTrapFrmSetControlGroupSelection	=	41355
sysTrapFrmCopyLabel	=	41356
sysTrapFrmSetLabel	=	41357
sysTrapFrmGetLabel	=	41358
sysTrapFrmSetCategoryLabel	=	41359
sysTrapFrmGetTitle	=	41360
sysTrapFrmSetTitle	=	41361
sysTrapFrmAlert	=	41362
sysTrapFrmDoDialog	=	41363
sysTrapFrmCustomAlert	=	41364
sysTrapFrmHelp	=	41365
sysTrapFrmUpdateScrollers	=	41366
sysTrapFrmGetFirstForm	=	41367
sysTrapFrmVisible	=	41368
sysTrapFrmGetObjectBounds	=	41369
sysTrapFrmCopyTitle	=	41370
sysTrapFrmGotoForm	=	41371
sysTrapFrmPopupForm	=	41372
sysTrapFrmUpdateForm	=	41373
sysTrapFrmReturnToForm	=	41374
sysTrapFrmSetEventHandler	=	41375
sysTrapFrmDispatchEvent	=	41376
sysTrapFrmCloseAllForms	=	41377
sysTrapFrmSaveAllForms	=	41378
sysTrapFrmGetGadgetData	=	41379
sysTrapFrmSetGadgetData	=	41380
sysTrapFrmSetCategoryTrigger	=	41381
sysTrapUIInitialize	=	41382
sysTrapUIReset	=	41383
sysTrapInsPtInitialize	=	41384
sysTrapInsPtSetLocation	=	41385
sysTrapInsPtGetLocation	=	41386
sysTrapInsPtEnable	=	41387
sysTrapInsPtEnabled	=	41388
sysTrapInsPtSetHeight	=	41389
sysTrapInsPtGetHeight	=	41390
sysTrapInsPtCheckBlink	=	41391
sysTrapLstSetDrawFunction	=	41392
sysTrapLstDrawList	=	41393
sysTrapLstEraseList	=	41394
sysTrapLstGetSelection	=	41395
sysTrapLstGetSelectionText	=	41396
sysTrapLstHandleEvent	=	41397
sysTrapLstSetHeight	=	41398
sysTrapLstSetSelection	=	41399
sysTrapLstSetListChoices	=	41400
sysTrapLstMakeItemVisible	=	41401
sysTrapLstGetNumberOfItems	=	41402
sysTrapLstPopupList	=	41403
sysTrapLstSetPosition	=	41404
sysTrapMenuInit	=	41405
sysTrapMenuDispose	=	41406
sysTrapMenuHandleEvent	=	41407
sysTrapMenuDrawMenu	=	41408
sysTrapMenuEraseStatus	=	41409
sysTrapMenuGetActiveMenu	=	41410
sysTrapMenuSetActiveMenu	=	41411
sysTrapRctSetRectangle	=	41412
sysTrapRctCopyRectangle	=	41413
sysTrapRctInsetRectangle	=	41414
sysTrapRctOffsetRectangle	=	41415
sysTrapRctPtInRectangle	=	41416
sysTrapRctGetIntersection	=	41417
sysTrapTblDrawTable	=	41418
sysTrapTblEraseTable	=	41419
sysTrapTblHandleEvent	=	41420
sysTrapTblGetItemBounds	=	41421
sysTrapTblSelectItem	=	41422
sysTrapTblGetItemInt	=	41423
sysTrapTblSetItemInt	=	41424
sysTrapTblSetItemStyle	=	41425
sysTrapTblUnhighlightSelection	=	41426
sysTrapTblSetRowUsable	=	41427
sysTrapTblGetNumberOfRows	=	41428
sysTrapTblSetCustomDrawProcedure	=	41429
sysTrapTblSetRowSelectable	=	41430
sysTrapTblRowSelectable	=	41431
sysTrapTblSetLoadDataProcedure	=	41432
sysTrapTblSetSaveDataProcedure	=	41433
sysTrapTblGetBounds	=	41434
sysTrapTblSetRowHeight	=	41435
sysTrapTblGetColumnWidth	=	41436
sysTrapTblGetRowID	=	41437
sysTrapTblSetRowID	=	41438
sysTrapTblMarkRowInvalid	=	41439
sysTrapTblMarkTableInvalid	=	41440
sysTrapTblGetSelection	=	41441
sysTrapTblInsertRow	=	41442
sysTrapTblRemoveRow	=	41443
sysTrapTblRowInvalid	=	41444
sysTrapTblRedrawTable	=	41445
sysTrapTblRowUsable	=	41446
sysTrapTblReleaseFocus	=	41447
sysTrapTblEditing	=	41448
sysTrapTblGetCurrentField	=	41449
sysTrapTblSetColumnUsable	=	41450
sysTrapTblGetRowHeight	=	41451
sysTrapTblSetColumnWidth	=	41452
sysTrapTblGrabFocus	=	41453
sysTrapTblSetItemPtr	=	41454
sysTrapTblFindRowID	=	41455
sysTrapTblGetLastUsableRow	=	41456
sysTrapTblGetColumnSpacing	=	41457
sysTrapTblFindRowData	=	41458
sysTrapTblGetRowData	=	41459
sysTrapTblSetRowData	=	41460
sysTrapTblSetColumnSpacing	=	41461
sysTrapTblSetColumnMasked	=	41936
sysTrapTblSetRowMasked	=	41937
sysTrapTblRowMasked	=	41938
sysTrapTblGetNumberOfColumns	=	42065
sysTrapTblGetTopRow	=	42066
sysTrapTblSetSelection	=	42067
sysTrapWinCreateWindow	=	41462
sysTrapWinCreateOffscreenWindow	=	41463
sysTrapWinDeleteWindow	=	41464
sysTrapWinInitializeWindow	=	41465
sysTrapWinAddWindow	=	41466
sysTrapWinRemoveWindow	=	41467
sysTrapWinSetActiveWindow	=	41468
sysTrapWinSetDrawWindow	=	41469
sysTrapWinGetDrawWindow	=	41470
sysTrapWinGetActiveWindow	=	41471
sysTrapWinGetDisplayWindow	=	41472
sysTrapWinGetFirstWindow	=	41473
sysTrapWinEnableWindow	=	41474
sysTrapWinDisableWindow	=	41475
sysTrapWinGetWindowFrameRect	=	41476
sysTrapWinDrawWindowFrame	=	41477
sysTrapWinEraseWindow	=	41478
sysTrapWinSaveBits	=	41479
sysTrapWinRestoreBits	=	41480
sysTrapWinCopyRectangle	=	41481
sysTrapWinScrollRectangle	=	41482
sysTrapWinGetDisplayExtent	=	41483
sysTrapWinGetWindowExtent	=	41484
sysTrapWinDisplayToWindowPt	=	41485
sysTrapWinWindowToDisplayPt	=	41486
sysTrapWinGetClip	=	41487
sysTrapWinSetClip	=	41488
sysTrapWinResetClip	=	41489
sysTrapWinClipRectangle	=	41490
sysTrapWinDrawLine	=	41491
sysTrapWinDrawGrayLine	=	41492
sysTrapWinEraseLine	=	41493
sysTrapWinInvertLine	=	41494
sysTrapWinFillLine	=	41495
sysTrapWinDrawRectangle	=	41496
sysTrapWinEraseRectangle	=	41497
sysTrapWinInvertRectangle	=	41498
sysTrapWinDrawRectangleFrame	=	41499
sysTrapWinDrawGrayRectangleFrame	=	41500
sysTrapWinEraseRectangleFrame	=	41501
sysTrapWinInvertRectangleFrame	=	41502
sysTrapWinGetFramesRectangle	=	41503
sysTrapWinDrawChars	=	41504
sysTrapWinEraseChars	=	41505
sysTrapWinInvertChars	=	41506
sysTrapWinGetPattern	=	41507
sysTrapWinSetPattern	=	41508
sysTrapWinSetUnderlineMode	=	41509
sysTrapWinDrawBitmap	=	41510
sysTrapWinModal	=	41511
sysTrapWinGetWindowBounds	=	41512
sysTrapWinFillRectangle	=	41513
sysTrapWinDrawInvertedChars	=	41514
sysTrapWinGetPixel	=	41857
sysTrapWinSetBackColor	=	41881
sysTrapWinSetTextColor	=	41882
sysTrapPrefOpenPreferenceDBV10	=	41515
sysTrapPrefGetPreferences	=	41516
sysTrapPrefSetPreferences	=	41517
sysTrapPrefGetAppPreferencesV10	=	41518
sysTrapPrefSetAppPreferencesV10	=	41519
sysTrapSndInit	=	41520
sysTrapSndSetDefaultVolume	=	41521
sysTrapSndGetDefaultVolume	=	41522
sysTrapSndDoCmd	=	41523
sysTrapSndPlaySystemSound	=	41524
sysTrapAlmInit	=	41525
sysTrapAlmCancelAll	=	41526
sysTrapAlmAlarmCallback	=	41527
sysTrapAlmSetAlarm	=	41528
sysTrapAlmGetAlarm	=	41529
sysTrapAlmDisplayAlarm	=	41530
sysTrapAlmEnableNotification	=	41531
sysTrapHwrGetRAMMapping	=	41532
sysTrapHwrMemWritable	=	41533
sysTrapHwrMemReadable	=	41534
sysTrapHwrDoze	=	41535
sysTrapHwrSleep	=	41536
sysTrapHwrWake	=	41537
sysTrapHwrSetSystemClock	=	41538
sysTrapHwrSetCPUDutyCycle	=	41539
sysTrapHwrLCDInit	=	41540
sysTrapHwrLCDSleep	=	41541
sysTrapHwrTimerInit	=	41542
sysTrapHwrCursor	=	41543
sysTrapHwrBatteryLevel	=	41544
sysTrapHwrDelay	=	41545
sysTrapHwrEnableDataWrites	=	41546
sysTrapHwrDisableDataWrites	=	41547
sysTrapHwrLCDBaseAddr	=	41548
sysTrapHwrLCDDrawBitmap	=	41549
sysTrapHwrTimerSleep	=	41550
sysTrapHwrTimerWake	=	41551
sysTrapHwrLCDWake	=	41552
sysTrapHwrIRQ1Handler	=	41553
sysTrapHwrIRQ2Handler	=	41554
sysTrapHwrIRQ3Handler	=	41555
sysTrapHwrIRQ4Handler	=	41556
sysTrapHwrIRQ5Handler	=	41557
sysTrapHwrIRQ6Handler	=	41558
sysTrapHwrDockSignals	=	41559
sysTrapHwrPluggedIn	=	41560
sysTrapCrc16CalcBlock	=	41561
sysTrapSelectDayV10	=	41562
sysTrapSelectTimeV33	=	41563
sysTrapSelectTime	=	41926
sysTrapSelectOneTime	=	41807
sysTrapDayDrawDaySelector	=	41564
sysTrapDayHandleEvent	=	41565
sysTrapDayDrawDays	=	41566
sysTrapDayOfWeek	=	41567
sysTrapDaysInMonth	=	41568
sysTrapDayOfMonth	=	41569
sysTrapDateDaysToDate	=	41570
sysTrapDateToDays	=	41571
sysTrapDateAdjust	=	41572
sysTrapDateSecondsToDate	=	41573
sysTrapDateToAscii	=	41574
sysTrapDateToDOWDMFormat	=	41575
sysTrapTimeToAscii	=	41576
sysTrapFind	=	41577
sysTrapFindStrInStr	=	41578
sysTrapFindSaveMatch	=	41579
sysTrapFindGetLineBounds	=	41580
sysTrapFindDrawHeader	=	41581
sysTrapPenOpen	=	41582
sysTrapPenClose	=	41583
sysTrapPenGetRawPen	=	41584
sysTrapPenCalibrate	=	41585
sysTrapPenRawToScreen	=	41586
sysTrapPenScreenToRaw	=	41587
sysTrapPenResetCalibration	=	41588
sysTrapPenSleep	=	41589
sysTrapPenWake	=	41590
sysTrapResLoadForm	=	41591
sysTrapResLoadMenu	=	41592
sysTrapFtrInit	=	41593
sysTrapFtrUnregister	=	41594
sysTrapFtrGet	=	41595
sysTrapFtrSet	=	41596
sysTrapFtrGetByIndex	=	41597
sysTrapGrfInit	=	41598
sysTrapGrfFree	=	41599
sysTrapGrfGetState	=	41600
sysTrapGrfSetState	=	41601
sysTrapGrfFlushPoints	=	41602
sysTrapGrfAddPoint	=	41603
sysTrapGrfInitState	=	41604
sysTrapGrfCleanState	=	41605
sysTrapGrfMatch	=	41606
sysTrapGrfGetMacro	=	41607
sysTrapGrfFilterPoints	=	41608
sysTrapGrfGetNumPoints	=	41609
sysTrapGrfGetPoint	=	41610
sysTrapGrfFindBranch	=	41611
sysTrapGrfMatchGlyph	=	41612
sysTrapGrfGetGlyphMapping	=	41613
sysTrapGrfGetMacroName	=	41614
sysTrapGrfDeleteMacro	=	41615
sysTrapGrfAddMacro	=	41616
sysTrapGrfGetAndExpandMacro	=	41617
sysTrapGrfProcessStroke	=	41618
sysTrapGrfFieldChange	=	41619
sysTrapGetCharSortValue	=	41620
sysTrapGetCharAttr	=	41621
sysTrapGetCharCaselessValue	=	41622
sysTrapPwdExists	=	41623
sysTrapPwdVerify	=	41624
sysTrapPwdSet	=	41625
sysTrapPwdRemove	=	41626
sysTrapGsiInitialize	=	41627
sysTrapGsiSetLocation	=	41628
sysTrapGsiEnable	=	41629
sysTrapGsiEnabled	=	41630
sysTrapGsiSetShiftState	=	41631
sysTrapKeyInit	=	41632
sysTrapKeyHandleInterrupt	=	41633
sysTrapKeyCurrentState	=	41634
sysTrapKeyResetDoubleTap	=	41635
sysTrapKeyRates	=	41636
sysTrapKeySleep	=	41637
sysTrapKeyWake	=	41638
sysTrapDlkControl	=	41639
sysTrapDlkStartServer	=	41640
sysTrapDlkGetSyncInfo	=	41641
sysTrapDlkSetLogEntry	=	41642
sysTrapUnused2	=	41643
sysTrapSysLibLoad	=	41644
sysTrapSndPlaySmf	=	41645
sysTrapSndCreateMidiList	=	41646
sysTrapAbtShowAbout	=	41647
sysTrapMdmDial	=	41648
sysTrapMdmHangUp	=	41649
sysTrapDmSearchRecord	=	41650
sysTrapSysInsertionSort	=	41651
sysTrapDmInsertionSort	=	41652
sysTrapLstSetTopItem	=	41653
			| PalmOS 2.X traps
sysTrapSclSetScrollBar	=	41654
sysTrapSclDrawScrollBar	=	41655
sysTrapSclHandleEvent	=	41656
sysTrapSysMailboxCreate	=	41657
sysTrapSysMailboxDelete	=	41658
sysTrapSysMailboxFlush	=	41659
sysTrapSysMailboxSend	=	41660
sysTrapSysMailboxWait	=	41661
sysTrapSysTaskWait	=	41662
sysTrapSysTaskWake	=	41663
sysTrapSysTaskWaitClr	=	41664
sysTrapSysTaskSuspend	=	41665
sysTrapSysTaskResume	=	41666
sysTrapCategoryCreateList	=	41667
sysTrapCategoryFreeList	=	41668
sysTrapCategoryEditV20	=	41669
sysTrapCategorySelect	=	41670
sysTrapDmDeleteCategory	=	41671
sysTrapSysEvGroupCreate	=	41672
sysTrapSysEvGroupSignal	=	41673
sysTrapSysEvGroupRead	=	41674
sysTrapSysEvGroupWait	=	41675
sysTrapEvtEventAvail	=	41676
sysTrapEvtSysEventAvail	=	41677
sysTrapStrNCopy	=	41678
sysTrapKeySetMask	=	41679
sysTrapSelectDay	=	41680
sysTrapPrefGetPreference	=	41681
sysTrapPrefSetPreference	=	41682
sysTrapPrefGetAppPreferences	=	41683
sysTrapPrefSetAppPreferences	=	41684
sysTrapFrmPointInTitle	=	41685
sysTrapStrNCat	=	41686
sysTrapMemCmp	=	41687
sysTrapTblSetColumnEditIndicator	=	41688
sysTrapFntWordWrap	=	41689
sysTrapFldGetScrollValues	=	41690
sysTrapSysCreateDataBaseList	=	41691
sysTrapSysCreatePanelList	=	41692
sysTrapDlkDispatchRequest	=	41693
sysTrapStrPrintF	=	41694
sysTrapStrVPrintF	=	41695
sysTrapPrefOpenPreferenceDB	=	41696
sysTrapSysGraffitiReferenceDialog	=	41697
sysTrapSysKeyboardDialog	=	41698
sysTrapFntWordWrapReverseNLines	=	41699
sysTrapFntGetScrollValues	=	41700
sysTrapTblSetRowStaticHeight	=	41701
sysTrapTblHasScrollBar	=	41702
sysTrapSclGetScrollBar	=	41703
sysTrapFldGetNumberOfBlankLines	=	41704
sysTrapSysTicksPerSecond	=	41705
sysTrapHwrBacklight	=	41706
sysTrapHwrDisplayAttributes	=	41842
sysTrapDmDatabaseProtect	=	41707
sysTrapTblSetBounds	=	41708
sysTrapStrNCompare	=	41709
sysTrapStrNCaselessCompare	=	41710
sysTrapPhoneNumberLookup	=	41711
sysTrapFrmSetMenu	=	41712
sysTrapEncDigestMD5	=	41713
sysTrapDmFindSortPosition	=	41714
sysTrapSysBinarySearch	=	41715
sysTrapSysErrString	=	41716
sysTrapSysStringByIndex	=	41717
sysTrapEvtAddUniqueEventToQueue	=	41718
sysTrapStrLocalizeNumber	=	41719
sysTrapStrDelocalizeNumber	=	41720
sysTrapLocGetNumberSeparators	=	41721
sysTrapMenuSetActiveMenuRscID	=	41722
sysTrapLstScrollList	=	41723
sysTrapCategoryInitialize	=	41724
sysTrapEncDigestMD4	=	41725
sysTrapEncDES	=	41726
sysTrapLstGetVisibleItems	=	41727
sysTrapWinSetWindowBounds	=	41728
sysTrapCategorySetName	=	41729
sysTrapFldSetInsertionPoint	=	41730
sysTrapFrmSetObjectBounds	=	41731
sysTrapWinSetColors	=	41732
sysTrapFlpDispatch	=	41733
sysTrapFlpEmDispatch	=	41734
sysTrapPceNativeCall	=	42074
sysLibTrapSerName	=	43008
sysLibTrapSerOpen	=	43009
sysLibTrapSerClose	=	43010
sysLibTrapSerSleep	=	43011
sysLibTrapSerWake	=	43012
sysLibTrapSerGetSettings	=	43013
sysLibTrapSerSetSettings	=	43014
sysLibTrapSerGetStatus	=	43015
sysLibTrapSerClearErr	=	43016
sysLibTrapSerSend10	=	43017
sysLibTrapSerSendWait	=	43018
sysLibTrapSerSendCheck	=	43019
sysLibTrapSerSendFlush	=	43020
sysLibTrapSerReceive10	=	43021
sysLibTrapSerReceiveWait	=	43022
sysLibTrapSerReceiveCheck	=	43023
sysLibTrapSerReceiveFlush	=	43024
sysLibTrapSerSetReceiveBuffer	=	43025
			| defined for system use only
sysLibTrapSerReceiveWindowOpen	=	0x0A805+13
sysLibTrapSerReceiveWindowClose	=	0x0A805+14
sysLibTrapSerSetWakeupHandler	=	0x0A805+15
sysLibTrapSerPrimeWakeupHandler	=	0x0A805+16
sysLibTrapSerControl	=	0x0A805+17
			| from PalmOS 2.0
sysLibTrapSerSend	=	0x0A805+18
sysLibTrapSerReceive	=	0x0A805+19
			| system\DLServer.h  -- RCM 10/15/01
			| DirectLink Server (Hotsync) functions
sysTrapDlkGetSyncInfo	=	0x0A2A9	| allows us to get the User Name
			| PalmOS 3.5 traps
sysTrapBltFindIndexes	=	0xA375
sysTrapBmpGetBits	=	0xA376
sysTrapBltCopyRectangle	=	0xA377
sysTrapBltDrawChars	=	0xA378
sysTrapBltLineRoutine	=	0xA379
sysTrapBltRectangleRoutine	=	0xA37A
sysTrapScrCompress	=	0xA37B
sysTrapScrDecompress	=	0xA37C
sysTrapSysLCDBrightness	=	0xA37D
sysTrapWinPaintChar	=	0xA37E
sysTrapWinPaintChars	=	41855
sysTrapWinPaintBitmap	=	0xA380
sysTrapWinGetPixel	=	0xA381
sysTrapWinPaintPixel	=	0xA382
sysTrapWinDrawPixel	=	0xA383
sysTrapWinErasePixel	=	0xA384
sysTrapWinInvertPixel	=	0xA385
sysTrapWinPaintPixels	=	0xA386
sysTrapWinPaintLines	=	0xA387
sysTrapWinPaintLine	=	0xA388
sysTrapWinPaintRectangle	=	0xA389
sysTrapWinPaintRectangleFrame	=	0xA38A
sysTrapWinPaintPolygon	=	0xA38B
sysTrapWinDrawPolygon	=	0xA38C
sysTrapWinErasePolygon	=	0xA38D
sysTrapWinInvertPolygon	=	0xA38E
sysTrapWinFillPolygon	=	0xA38F
sysTrapWinPaintArc	=	0xA390
sysTrapWinDrawArc	=	0xA391
sysTrapWinEraseArc	=	0xA392
sysTrapWinInvertArc	=	0xA393
sysTrapWinFillArc	=	0xA394
sysTrapWinPushDrawState	=	41877
sysTrapWinPopDrawState	=	41878
sysTrapWinSetDrawMode	=	41879
sysTrapWinSetForeColor	=	41880
sysTrapWinRGBToIndex	=	41886
sysTrapWinCreateBitmapWindow	=	41956
			| system\bitmap.h  -- RCM 10/15/01
			| Window bitmap functions
sysTrapBmpCreate	=	0x0A3DD
sysTrapBmpDelete	=	0x0A3DE
sysTrapBmpCompress	=	0x0A3DF
sysTrapBmpGetColortable	=	0x0A3E0
sysTrapBmpGetBits	=	0x0A376	|  was BltGetBitsAddr
sysTrapBmpSize	=	0x0A3E1
sysTrapBmpBitsSize	=	0x0A3E2
sysTrapBmpColortableSize	=	0x0A3E3
sysTrapWinCreateBitmapWindow	=	0x0A3E4
sysTrapWinGetBitmap	=	0x0A3A2
sysTrapWinPalette	=	0x0A39D
sysTrapWinPaintBitmap	=	0x0A380
			| PalmOS 3.X traps
sysTrapExgInit	=	41735
sysTrapExgConnect	=	41736
sysTrapExgPut	=	41737
sysTrapExgGet	=	41738
sysTrapExgAccept	=	41739
sysTrapExgDisconnect	=	41740
sysTrapExgSend	=	41741
sysTrapExgReceive	=	41742
sysTrapExgRegisterData	=	41743
sysTrapExgNotifyReceive	=	41744
sysTrapExgControl	=	41745
sysTrapPrgStartDialog	=	41746
sysTrapPrgStopDialog	=	41747
sysTrapPrgUpdateDialog	=	41748
sysTrapPrgHandleEvent	=	41749
sysTrapImcReadFieldNoSemicolon	=	41750
sysTrapImcReadFieldQuotablePrintable	=	41751
sysTrapImcReadPropertyParameter	=	41752
sysTrapImcSkipAllPropertyParameters	=	41753
sysTrapImcReadWhiteSpace	=	41754
sysTrapImcWriteQuotedPrintable	=	41755
sysTrapImcWriteNoSemicolon	=	41756
sysTrapImcStringIsAscii	=	41757
sysTrapTblGetItemFont	=	41758
sysTrapTblSetItemFont	=	41759
sysTrapFontSelect	=	41760
sysTrapFntDefineFont	=	41761
sysTrapCategoryEdit	=	41762
sysTrapSysGetOSVersionString	=	41763
sysTrapSysBatteryInfo	=	41764
sysTrapSysUIBusy	=	41765
sysTrapWinValidateHandle	=	41766
sysTrapFrmValidatePtr	=	41767
sysTrapCtlValidatePointer	=	41768
sysTrapWinMoveWindowAddr	=	41769
sysTrapFrmAddSpaceForObject	=	41770
sysTrapFrmNewForm	=	41771
sysTrapCtlNewControl	=	41772
sysTrapFldNewField	=	41773
sysTrapLstNewList	=	41774
sysTrapFrmNewLabel	=	41775
sysTrapFrmNewBitmap	=	41776
sysTrapFrmNewGadget	=	41777
sysTrapFileOpen	=	41778
sysTrapFileClose	=	41779
sysTrapFileDelete	=	41780
sysTrapFileReadLow	=	41781
sysTrapFileWrite	=	41782
sysTrapFileSeek	=	41783
sysTrapFileTell	=	41784
sysTrapFileTruncate	=	41785
sysTrapFileControl	=	41786
sysTrapFrmActiveState	=	41787
sysTrapSysGetAppInfo	=	41788
sysTrapSysGetStackInfo	=	41789
sysTrapScrDisplayMode	=	41790
			| determine the screen mode of our device
sysTrapWinScreenMode	=	sysTrapScrDisplayMode	| was sysTrapScrDisplayMode
sysTrapHwrLCDGetDepth	=	41791
sysTrapHwrGetROMToken	=	41792
sysTrapDbgControl	=	41793
sysTrapExgDBRead	=	41794
sysTrapExgDBWrite	=	41795
sysTrapSysGremlins	=	41796
sysTrapHostControl	=	sysTrapSysGremlins	| renamed
sysTrapFrmRemoveObject	=	41797
sysTrapSysReserved1	=	41798
sysTrapExpansionDispatch	=	41799
sysTrapSysReserved3	=	41800
sysTrapSysReserved4	=	41801
sysTrapLastTrapNumber	=	41802
sysNumTraps	=	sysTrapLastTrapNumber-sysTrapBase
sysLibTrapBase	=	0xA800
sysLibTrapName	=	0xA800
sysLibTrapOpen	=	0xA801
sysLibTrapClose	=	0xA802
sysLibTrapSleep	=	0xA803
sysLibTrapWake	=	0xA804
sysLibTrapCustom	=	0xA805
sysDbgBreakpointTrapNum	=	0
sysDbgTrapNum	=	8
sysDispatchTrapNum	=	15
			| Palm Networking Library calls -- RCM 1/25/02
sysLibTrapNetLibOpen	=	sysLibTrapOpen
sysLibTrapNetLibClose	=	sysLibTrapClose
sysLibTrapNetLibSleep	=	sysLibTrapSleep
sysLibTrapNetLibWake	=	sysLibTrapWake
sysLibTrapNetLibAddrINToA	=	sysLibTrapCustom
sysLibTrapNetLibAddrAToIN	=	sysLibTrapCustom+1
sysLibTrapNetLibSocketOpen	=	sysLibTrapCustom+2
sysLibTrapNetLibSocketClose	=	sysLibTrapCustom+3
sysLibTrapNetLibSocketOptionGet	=	sysLibTrapCustom+5
sysLibTrapNetLibSocketOptionSet	=	sysLibTrapCustom+4
sysLibTrapNetLibSocketConnect	=	sysLibTrapCustom+7
sysLibTrapNetLibSocketBind	=	sysLibTrapCustom+6
sysLibTrapNetLibSocketListen	=	sysLibTrapCustom+8
sysLibTrapNetLibSocketAccept	=	sysLibTrapCustom+9
sysLibTrapNetLibSocketShutdown	=	sysLibTrapCustom+10
sysLibTrapNetLibSend	=	sysLibTrapCustom+12
sysLibTrapNetLibReceive	=	sysLibTrapCustom+14
sysLibTrapNetLibGetHostByName	=	sysLibTrapCustom+22
			| AppBuildRules.h
SHELL_COMMAND_DB	=	0
SHELL_COMMAND_UI	=	0
SHELL_COMMAND_APP	=	0
SHELL_COMMAND_EMULATOR	=	1
			| Core\CoreTraps.h -- KP 3/21/02
sysTrapSerialDispatch	=	0x0A367
sysSerialInstall	=	0
sysSerialOpen	=	1
sysSerialOpenBkgnd	=	2
sysSerialClose	=	3
sysSerialSleep	=	4
sysSerialWake	=	5
sysSerialGetDeviceCount	=	6
sysSerialGetDeviceInfo	=	7
sysSerialGetStatus	=	8
sysSerialClearErr	=	9
sysSerialControl	=	10
sysSerialSend	=	11
sysSerialSendWait	=	12
sysSerialSendCheck	=	13
sysSerialSendFlush	=	14
sysSerialReceive	=	15
sysSerialReceiveWait	=	16
sysSerialReceiveCheck	=	17
sysSerialReceiveFlush	=	18
sysSerialSetRcvBuffer	=	19
sysSerialRcvWindowOpen	=	20
sysSerialRcvWindowClose	=	21
sysSerialSetWakeupHandler	=	22
sysSerialPrimeWakeupHandler	=	23
sysSerialOpenV4	=	24
sysSerialOpenBkgndV4	=	25
sysSerialCustomControl	=	26
			| BuildRules.h
EMULATION_NONE	=	0
EMULATION_WINDOWS	=	1
EMULATION_DOS	=	2
EMULATION_MAC	=	3
MEMORY_LOCAL	=	0
MEMORY_REMOTE	=	1
ENVIRONMENT_CW	=	0
ENVIRONMENT_MPW	=	1
ERROR_CHECK_NONE	=	0
ERROR_CHECK_PARTIAL	=	1
ERROR_CHECK_FULL	=	2
CPU_68K	=	0
CPU_x86	=	1
HW_TARGET_NONE	=	0
HW_TARGET_302	=	1
HW_TARGET_328EMU	=	2
HW_TARGET_328	=	3
HW_TARGET_TD1	=	4
MEMORY_FORCE_LOCK_OFF	=	0
MEMORY_FORCE_LOCK_ON	=	1
DEBUG_LEVEL_NONE	=	1
DEBUG_LEVEL_PARTIAL	=	2
DEBUG_LEVEL_FULL	=	3
CONSOLE_SERIAL_LIB_68328	=	1
CONSOLE_SERIAL_LIB_68681	=	2
COUNTRY_UNITED_STATES	=	0
COUNTRY_FRANCE	=	1
COUNTRY_GERMANY	=	2
COUNTRY_ITALY	=	3
COUNTRY_SPAIN	=	4
LANGUAGE_ENGLISH	=	0
LANGUAGE_FRENCH	=	1
LANGUAGE_GERMAN	=	2
LANGUAGE_ITALIAN	=	3
LANGUAGE_SPANISH	=	4
LANGUAGE_WORKPAD	=	5
USER_MODE_NORMAL	=	0
USER_MODE_DEMO	=	1
INTERNAL_COMMANDS_EXCLUDE	=	0
INTERNAL_COMMANDS_INCLUDE	=	1
MEMORY_VERSION_1	=	1
MEMORY_VERSION_2	=	2
GRAPHICS_VERSION_1	=	1
GRAPHICS_VERSION_2	=	2
INCLUDE_DES_OFF	=	0
INCLUDE_DES_ON	=	1
EMULATION_LEVEL	=	0
USE_TRAPS	=	1
MEMORY_TYPE	=	MEMORY_LOCAL
ENVIRONMENT	=	ENVIRONMENT_CW
ERROR_CHECK_LEVEL	=	ERROR_CHECK_FULL
CPU_TYPE	=	CPU_68K
HW_TARGET	=	HW_TARGET_NONE
MEMORY_FORCE_LOCK	=	MEMORY_FORCE_LOCK_ON
COUNTRY	=	COUNTRY_UNITED_STATES
LANGUAGE	=	LANGUAGE_ENGLISH
USER_MODE	=	USER_MODE_NORMAL
INTERNAL_COMMANDS	=	INTERNAL_COMMANDS_EXCLUDE
MEMORY_VERSION	=	MEMORY_VERSION_2
GRAPHICS_VERSION	=	GRAPHICS_VERSION_2
			|INCLUDE_DES		equ	INCUDE_DES_OFF
			| Common.h
NULL	=	0
true	=	1
false	=	0
			| System\SystemMgr.h
sysAppLaunchCmdNormalLaunch	=	0
sysAppLaunchCmdFind	=	1
sysAppLaunchCmdGoTo	=	2
sysAppLaunchCmdSyncNotify	=	3
sysAppLaunchCmdTimeChange	=	4
sysAppLaunchCmdSystemReset	=	5
sysAppLaunchCmdAlarmTriggered	=	6
sysAppLaunchCmdDisplayAlarm	=	7
sysAppLaunchCmdCountryChange	=	8
sysAppLaunchCmdSyncRequestLocal	=	9
sysAppLaunchCmdSyncRequest	=	sysAppLaunchCmdSyncRequestLocal
sysAppLaunchCmdSaveData	=	10
sysAppLaunchCmdInitDatabase	=	11
sysAppLaunchCmdSyncCallApplicationV10	=	12
sysAppLaunchCmdPanelCalledFromApp	=	13
sysAppLaunchCmdReturnFromPanel	=	14
sysAppLaunchCmdLookup	=	15
sysAppLaunchCmdSystemLock	=	16
sysAppLaunchCmdSyncRequestRemote	=	17
sysAppLaunchCmdHandleSyncCallApp	=	18
sysAppLaunchCmdAddRecord	=	19
sysSvcLaunchCmdSetServiceID	=	20
sysSvcLaunchCmdGetServiceID	=	21
sysSvcLaunchCmdGetServiceList	=	22
sysSvcLaunchCmdGetServiceInfo	=	23
sysAppLaunchCmdFailedAppNotify	=	24
sysAppLaunchCmdEventHook	=	25
sysAppLaunchCmdExgReceiveData	=	26
sysAppLaunchCmdExgAskUser	=	27
sysDialLaunchCmdDial	=	30
sysDialLaunchCmdHangUp	=	31
sysDialLaunchCmdLast	=	39
sysSvcLaunchCmdGetQuickEditLabel	=	40
sysSvcLaunchCmdLast	=	49
sysAppLaunchCmdCustomBase	=	0x8000
sysAppLaunchFlagNewThread	=	0x01
sysAppLaunchFlagNewStack	=	0x02
sysAppLaunchFlagNewGlobals	=	0x04
sysAppLaunchFlagUIApp	=	0x08
sysAppLaunchFlagSubCall	=	0x10
sysAppLaunchFlagDataRelocated	=	0x80
sysAppLaunchFlagPrivateSet	=	sysAppLaunchFlagSubCall|sysAppLaunchFlagDataRelocated
SysAppLaunchCmdSaveDataType.uiComing = 0
SysAppLaunchCmdSystemResetType.hardReset = 0
SysAppLaunchCmdSystemResetType.createDefaultDB = 0
SysAppLaunchCmdInitDatabaseType.dbP = 0
SysAppLaunchCmdInitDatabaseType.creator = 4
SysAppLaunchCmdInitDatabaseType.type = 8
SysAppLaunchCmdInitDatabaseType.version = 12
SysAppLaunchCmdSyncCallApplicationTypeV10.action = 0
SysAppLaunchCmdSyncCallApplicationTypeV10.paramSize = 2
SysAppLaunchCmdSyncCallApplicationTypeV10.paramP = 4
SysAppLaunchCmdSyncCallApplicationTypeV10.remoteSocket = 8
SysAppLaunchCmdSyncCallApplicationTypeV10.tid = 8
SysAppLaunchCmdSyncCallApplicationTypeV10.handled = 8
SysAppLaunchCmdSyncCallApplicationTypeV10.bPad = 8
SysAppLaunchCmdHandleSyncCallAppType.pbSize = 0
SysAppLaunchCmdHandleSyncCallAppType.action = 2
SysAppLaunchCmdHandleSyncCallAppType.paramP = 4
SysAppLaunchCmdHandleSyncCallAppType.dwParamSize = 8
SysAppLaunchCmdHandleSyncCallAppType.dlRefP = 12
SysAppLaunchCmdHandleSyncCallAppType.handled = 16
SysAppLaunchCmdHandleSyncCallAppType.pad = 16
SysAppLaunchCmdHandleSyncCallAppType.replyErr = 16
SysAppLaunchCmdHandleSyncCallAppType.dwReserved1 = 18
SysAppLaunchCmdHandleSyncCallAppType.dwReserved2 = 22
SysAppLaunchCmdFailedAppNotifyType.creator = 0
SysAppLaunchCmdFailedAppNotifyType.type = 4
SysAppLaunchCmdFailedAppNotifyType.result = 8
SysLibTblEntryType.dispatchTblP = 0
SysLibTblEntryType.globalsP = 4
SysLibTblEntryType.dbID = 8
SysLibTblEntryType.codeRscH = 12
sysDbgCommLibraryRefNum	=	0
sysInvalidRefNum	=	0xFFFF
memErrorClass	=	0x0100
dmErrorClass	=	0x0200
serErrorClass	=	0x0300
slkErrorClass	=	0x0400
sysErrorClass	=	0x0500
fplErrorClass	=	0x0600
flpErrorClass	=	0x0680
evtErrorClass	=	0x0700
sndErrorClass	=	0x0800
almErrorClass	=	0x0900
timErrorClass	=	0x0A00
penErrorClass	=	0x0B00
ftrErrorClass	=	0x0C00
cmpErrorClass	=	0x0D00
dlkErrorClass	=	0x0E00
padErrorClass	=	0x0F00
grfErrorClass	=	0x1000
mdmErrorClass	=	0x1100
netErrorClass	=	0x1200
htalErrorClass	=	0x1300
inetErrorClass	=	0x1400
exgErrorClass	=	0x1500
fileErrorClass	=	0x1600
rfutErrorClass	=	0x1700
appErrorClass	=	0x8000
sysErrTimeout	=	sysErrorClass|1
sysErrParamErr	=	sysErrorClass|2
sysErrNoFreeResource	=	sysErrorClass|3
sysErrNoFreeRAM	=	sysErrorClass|4
sysErrNotAllowed	=	sysErrorClass|5
sysErrSemInUse	=	sysErrorClass|6
sysErrInvalidID	=	sysErrorClass|7
sysErrOutOfOwnerIDs	=	sysErrorClass|8
sysErrNoFreeLibSlots	=	sysErrorClass|9
sysErrLibNotFound	=	sysErrorClass|10
sysErrDelayWakened	=	sysErrorClass|11
sysErrRomIncompatible	=	sysErrorClass|12
sysFtrCreator	=	sysFileCSystem
sysFtrNumROMVersion	=	1
			|sysFtrNumProductID	equ	2	; Obsolete in 3.1+
sysFtrNumBacklight	=	3
sysFtrNumEncryption	=	4
sysFtrNumEncryptionMaskDES	=	0x00000001
sysFtrNumCountry	=	5
sysFtrNumLanguage	=	6
sysFtrNumDisplayDepth	=	7
sysFtrNumProcessorID	=	2	| 0xMMMMRRRR, where MMMM is the processor model and RRRR is the revision.
sysFtrNumProcessorMask	=	0xFFFF0000	| Mask to obtain processor model
sysFtrNumProcessor328	=	0x00010000	| Motorola 68328  (Dragonball)
sysFtrNumProcessorEZ	=	0x00020000	| Motorola 68EZ328  (Dragonball
sysROMTokenSnum	=	0x736e756d
sysROMStageDevelopment	=	0
sysROMStageAlpha	=	1
sysROMStageBeta	=	2
sysROMStageRelease	=	3
			| SysBatteryKind
sysBatteryKindAlkaline	=	0
sysBatteryKindNiCad	=	1
sysBatteryKindLithium	=	2
SysDBListItemType.name. = 0
SysDBListItemType.creator = 0
SysDBListItemType.type = 4
SysDBListItemType.version = 8
SysDBListItemType.dbID = 10
SysDBListItemType.cardNo = 14
SysDBListItemType.iconP = 16
SysMailboxMsgType.data. = 0
sysEvGroupSignalConstant	=	0
sysEvGroupSignalPulse	=	1
sysEvGroupWaitOR	=	0
sysEvGroupWaitAND	=	1
sysFileDescStdIn	=	0
			| System\SysUtils.h
sysRandomMax	=	0x7FFF
			| System\SystemPrv.h
sysCardSignature	=	0xFEEDBEEF
sysStoreSignature	=	0xFEEDFACE
sysLowMemSize	=	0x1480
sysInitStack	=	sysLowMemSize+0x1000
sysRAMOnlyCardHeaderOffset	=	0x0000000
sysCardHeaderSize	=	0x0100
sysROMStoreRelOffset	=	sysCardHeaderSize
sysStoreHeaderSize	=	0x0100
sysMaxHeapsPerCard	=	128
			|sysDefaultLibraries	equ	DEFAULT_LIB_ENTRIES
sysDefaultSerPort	=	1
sysDefaultSerBaud	=	57600
SysAppPrefs.priority = 0
SysAppPrefs.stackSize = 2
SysAppPrefs.minHeapSpace = 6
SysAppInfoType.cmd = 0
SysAppInfoType.cmdPBP = 2
SysAppInfoType.launchFlags = 6
SysAppInfoType.taskID = 8
SysAppInfoType.codeH = 12
SysAppInfoType.dbP = 16
SysAppInfoType.stackP = 20
SysAppInfoType.globalsChunkP = 24
SysAppInfoType.memOwnerID = 28
SysAppInfoType.dmAccessP = 30
SysAppInfoType.dmLastErr = 34
SysAppInfoType.errExceptionP = 36
SysAppInfoType.a5Ptr = 40
SysAppInfoType.stackEndP = 44
SysAppInfoType.globalEndP = 48
SysAppInfoType.rootP = 52
SysAppInfoType.extraP = 56
SysTCBUserInfoType.tmpAppInfoP = 0
SysTCBUserInfoType.rootAppInfoP = 4
SysTCBUserInfoType.initialA5 = 8
SysNVParamsType.rtcHours = 0
SysNVParamsType.rtcHourMinSecCopy = 4
sysFileDescNet	=	sysFileDescStdIn+1
sysResetFlagHardReset	=	0x01
sysResetFlagCreateDefaultDBs	=	0x02
sysResetFlagNoExtensions	=	0x04
sysPrefFlagTaxiDisable	=	0x0001
sysPrefFlagEnableEasterEggs	=	0x0002
sysPrefFlagTaxiDisIdle	=	0x8000
sysPrefFlagTaxiDisIdleTime	=	0x4000
sysMiscFlagInFatalAlert	=	0x0001
sysMiscFlagAlwaysSwitchApp	=	0x0002
sysMiscFlagProfile	=	0x0004
sysMiscFlagGrfDisable	=	0x0008
sysMiscFlagInDemoAlert	=	0x0010
sysMiscFlagBacklightDisable	=	0x0020
sysMiscFlagUIInitialized	=	0x0040
sysMiscFlagExgEvent	=	0x0080
dbgEnteredFlagPseudoNMI	=	0x80
			| Hardware\M68KHwr.h
m68kTrapInstr	=	0x4E40
m68kTrapVectorMask	=	0x000F
M68KExcTableType.initStack = 0
M68KExcTableType.initPC = 4
M68KExcTableType.busErr = 8
M68KExcTableType.addressErr = 10
M68KExcTableType.illegalInstr = 12
M68KExcTableType.divideByZero = 16
M68KExcTableType.chk = 20
M68KExcTableType.trap = 24
M68KExcTableType.privilege = 28
M68KExcTableType.trace = 32
M68KExcTableType.aTrap = 36
M68KExcTableType.fTrap = 40
M68KExcTableType.reserved12 = 44
M68KExcTableType.coproc = 48
M68KExcTableType.formatErr = 52
M68KExcTableType.unitializedInt = 54
M68KExcTableType.reserved. = 58
M68KExcTableType.spuriousInt = 58
M68KExcTableType.autoVec1 = 62
M68KExcTableType.autoVec2 = 66
M68KExcTableType.autoVec3 = 70
M68KExcTableType.autoVec4 = 74
M68KExcTableType.autoVec5 = 78
M68KExcTableType.autoVec6 = 82
M68KExcTableType.autoVec7 = 86
M68KExcTableType.trapN. = 90
M68KExcTableType.unassigned. = 90
M68KRegsType.d. = 0
M68KRegsType.a. = 0
M68KRegsType.usp = 0
M68KRegsType.ssp = 4
M68KRegsType.pc = 8
M68KRegsType.sr = 12
m68kSrTraceMask	=	0x08000
m68kSrTraceBit	=	15
m68kSrSupervisorMask	=	0x02000
m68kSrInterruptMask	=	0x00700
m68kSrExtendMask	=	0x00010
m68kSrNegativeMask	=	0x00008
m68kSrZeroMask	=	0x00004
m68kSrOverflowMask	=	0x00002
m68kSrCarryMask	=	0x00001
			| System\SoundMgr.h
sndMaxAmp	=	64
sndDefaultAmp	=	sndMaxAmp
sndMidiNameLength	=	32
			| SndCmdIDType
sndCmdFreqDurationAmp	=	1
sndCmdNoteOn	=	2
sndCmdFrqOn	=	3
sndCmdQuiet	=	4
SndCommandType.cmd = 0
SndCommandType.param1 = 2
SndCommandType.param2 = 6
SndCommandType.param3 = 8
			| SndSysBeepType
sndInfo	=	1
sndWarning	=	2
sndError	=	3
sndStartUp	=	4
sndAlarm	=	5
sndConfirmation	=	6
sndClick	=	7
sndMidiRecSignature	=	0x504d7263
SndMidiRecHdrType.signature = 0
SndMidiRecHdrType.bDataOffset = 4
SndMidiRecHdrType.reserved = 4
SndMidiRecType.hdr.SndMidiRecHdrTy = 0
SndMidiRecType.name = 0
SndMidiListItemType.name. = 0
SndMidiListItemType.uniqueRecID = 0
SndMidiListItemType.dbID = 4
SndMidiListItemType.cardNo = 8
			| SndSmfCmdEnum
sndSmfCmdPlay	=	1
sndSmfCmdDuration	=	2
SndCallbackInfoType.funcP = 0
SndCallbackInfoType.dwUserData = 4
SndSmfCallbacksType.completion = 0
SndSmfCallbacksType.blocking = 4
SndSmfCallbacksType.reserved = 8
sndSmfPlayAllMilliSec	=	0xFFFFFFFF
SndSmfOptionsType.dwStartMilliSec = 0
SndSmfOptionsType.dwEndMilliSec = 4
SndSmfOptionsType.amplitude = 8
SndSmfOptionsType.interruptible = 10
SndSmfOptionsType.pad = 10
SndSmfOptionsType.reserved = 10
SndSmfChanRangeType.bFirstChan = 0
SndSmfChanRangeType.bLastChan = 0
sndErrBadParam	=	sndErrorClass|1
sndErrBadChannel	=	sndErrorClass|2
sndErrMemory	=	sndErrorClass|3
sndErrOpen	=	sndErrorClass|4
sndErrQFull	=	sndErrorClass|5
sndErrQEmpty	=	sndErrorClass|6
sndErrFormat	=	sndErrorClass|7
sndErrBadStream	=	sndErrorClass|8
sndErrInterrupted	=	sndErrorClass|9
			| System\SoundPrv.h
sndSamplingRate	=	8000
sndBeepDurationMSec	=	70
sndConfirmationDurationMSec	=	70
sndClickDurationMSec	=	9
sndInfoFreq	=	500
sndWarningFreq	=	500
sndErrorFreq	=	500
sndConfirmationFreq	=	500
sndStartUpFreq	=	1000
sndClickFreq	=	200
SndGlobalsType.smID = 0
SndGlobalsType.sysAmp = 4
SndGlobalsType.alarmAmp = 4
SndGlobalsType.defAmp = 4
SndGlobalsType.pad = 4
SndGlobalsType.wMidiFrqTabP = 4
			| System\Preferences.h
noPreferenceFound	=	-1
preferenceDataVersion	=	4
defaultAutoOffDuration	=	2
			| SoundLevelTypeV20
slOn	=	0
slOff	=	1
defaultSysSoundLevel	=	slOn
defaultGameSoundLevel	=	slOn
defaultAlarmSoundLevel	=	slOn
defaultSysSoundVolume	=	sndMaxAmp
defaultGameSoundVolume	=	sndMaxAmp
defaultAlarmSoundVolume	=	sndMaxAmp
			| CountryType;
cAustralia	=	0
cAustria	=	1
cBelgium	=	2
cBrazil	=	3
cCanada	=	4
cDenmark	=	5
cFinland	=	6
cFrance	=	7
cGermany	=	8
cHongKong	=	9
cIceland	=	10
cIreland	=	11
cItaly	=	12
cJapan	=	13
cLuxembourg	=	14
cMexico	=	15
cNetherlands	=	16
cNewZealand	=	17
cNorway	=	18
cSpain	=	19
cSweden	=	20
cSwitzerland	=	21
cUnitedKingdom	=	22
cUnitedStates	=	23
countryFirst	=	cAustralia
countryLast	=	cUnitedStates
countryCount	=	countryLast-countryFirst+1
			|???typedef enum
			|???	tfColon,
			|???	tfColonAMPM,
			|???	tfColon24h,
			|???	tfDot,
			|???	tfDotAMPM,
			|???	tfDot24h,
			|???	tfHoursAMPM,
			|???	tfHours24h,
			|???	tfComma24h
			|???	} TimeFormatType;
			|???typedef enum {
			|???	dsNone,
			|???	dsUSA,
			|???	dsAustralia,
			|???	dsWesternEuropean,
			|???	dsMiddleEuropean,
			|???	dsEasternEuropean,
			|???	dsGreatBritain,
			|???	dsRumania,
			|???	dsTurkey,
			|???	dsAustraliaShifted
			|???	} DaylightSavingsTypes;
			|???typedef enum {
			|???	dfMDYWithSlashes,
			|???	dfDMYWithSlashes,
			|???	dfDMYWithDots,
			|???	dfDMYWithDashes,
			|???	dfYMDWithSlashes,
			|???	dfYMDWithDots,
			|???	dfYMDWithDashes,
			|???	dfMDYLongWithComma,
			|???	dfDMYLong,
			|???	dfDMYLongWithDot,
			|???	dfDMYLongNoDay,
			|???	dfDMYLongWithComma,
			|???	dfYMDLongWithDot,
			|???	dfYMDLongWithSpace,
			|???	dfMYMed,
			|???	dfMYMedNoPost
			|???	} DateFormatType;
			|???typedef enum {
			|???	nfCommaPeriod,
			|???	nfPeriodComma,
			|???	nfSpaceComma,
			|???	nfApostrophePeriod,
			|???	nfApostropheComma
			|???	} NumberFormatType;
countryNameLength	=	20
currencyNameLength	=	20
currencySymbolLength	=	6
			|struct
			|	CountryType country;					// Country the structure represents
			|	countryName[countryNameLength].b
			|	DateFormatType dateFormat;			// Format to display date in
			|	longDateFormat.l
			|	weekStartDay.b
			|	TimeFormatType timeFormat;			// Format to display time in
			|	NumberFormatType numberFormat;	// Format to display numbers in
			|	currencyName[currencyNameLength].b
			|	currencySymbol[currencySymbolLength].b
			|	uniqueCurrencySymbol[currencySymbolLength].b
			|	currencyDecimalPlaces.b
			|	DaylightSavingsTypes	daylightSavings;	// Type of daylight savings correction
			|	minutesWestOfGMT.l
			|endstruct CountryPreferencesTypeCountryPreferencesType
			|???typedef enum {
			|???	alOff,
			|???	alEventsOnly,
			|???	alEventsAndRandom,
			|???	alEventsAndMoreRandom
			|???	} AnimationLevelType;
			|???typedef enum
			|???	prefVersion,
			|???	prefCountry,
			|???	prefDateFormat,
			|???	prefLongDateFormat,
			|???	prefWeekStartDay,
			|???	prefTimeFormat,
			|???	prefNumberFormat,
			|???	prefAutoOffDuration,
			|???	prefSysSoundLevelV20,
			|???	prefGameSoundLevelV20,
			|???	prefAlarmSoundLevelV20,
			|???	prefHidePrivateRecords,
			|???	prefDeviceLocked,
			|???	prefLocalSyncRequiresPassword,
			|???	prefRemoteSyncRequiresPassword,
			|???	prefSysBatteryKind,
			|???	prefAllowEasterEggs,
			|???	prefMinutesWestOfGMT,
			|???	prefDaylightSavings,
			|???	prefRonamaticChar,
			|???	prefHard1CharAppCreator,
			|???	prefHard2CharAppCreator,
			|???	prefHard3CharAppCreator,
			|???	prefHard4CharAppCreator,
			|???	prefCalcCharAppCreator,
			|???	prefHardCradleCharAppCreator,
			|???	prefLauncherAppCreator,
			|???	prefSysPrefFlags,
			|???	prefHardCradle2CharAppCreator,
			|???	prefAnimationLevel,
			|???	prefSysSoundVolume,
			|???	prefGameSoundVolume,
			|???	prefAlarmSoundVolume,
			|???	prefBeamReceive,
			|???	prefCalibrateDigitizerAtReset,
			|???	prefSystemKeyboardID,
			|???	prefDefSerialPlugIn
			|???	} SystemPreferencesChoice;
			|struct {
			|	version.w
			|	International.w
			|	CountryType country;					// Country the device is in
			|	DateFormatType dateFormat;			// Format to display date in
			|	longDateFormat.l
			|	weekStartDay.b
			|	TimeFormatType timeFormat;			// Format to display time in
			|	NumberFormatType numberFormat;	// Format to display numbers in
			|
			|	// system preferences
			|	autoOffDuration.b
			|	SoundLevelTypeV20 sysSoundLevel;		//	High, Med, Low, Off - error beeps
			|	SoundLevelTypeV20 alarmSoundLevel;	//	High, Med, Low, Off - alarm only
			|	hideSecretRecords.b
			|	deviceLocked.b
			|	sysPrefFlags.w
			|	SysBatteryKind	sysBatteryKind;	// The type of batteries installed. This
			|endstruct SystemPreferencesTypeV10SystemPreferencesTypeV10
SystemPreferencesTypeV10.version = 0
SystemPreferencesTypeV10.country = 2
SystemPreferencesTypeV10.dateFormat = 2
SystemPreferencesTypeV10.longDateFormat = 2
SystemPreferencesTypeV10.weekStartDay = 2
SystemPreferencesTypeV10.timeFormat = 2
SystemPreferencesTypeV10.numberFormat = 2
SystemPreferencesTypeV10.autoOffDuration = 2
SystemPreferencesTypeV10.sysSoundLevel = 2
SystemPreferencesTypeV10.alarmSoundLevel = 2
SystemPreferencesTypeV10.hideSecretRecords = 2
SystemPreferencesTypeV10.deviceLocked = 2
SystemPreferencesTypeV10.bPad = 2
SystemPreferencesTypeV10.sysPrefFlags = 2
SystemPreferencesTypeV10.sysBatteryKind = 4
SystemPreferencesTypeV10.bPad2 = 4
SystemPreferencesType.version = 0
SystemPreferencesType.International = 2
SystemPreferencesType.country = 4
SystemPreferencesType.dateFormat = 4
SystemPreferencesType.longDateFormat = 4
SystemPreferencesType.weekStartDay = 8
SystemPreferencesType.timeFormat = 8
SystemPreferencesType.numberFormat = 8
SystemPreferencesType.autoOffDuration = 8
SystemPreferencesType.sysSoundLevelV20 = 8
SystemPreferencesType.gameSoundLevelV20 = 8
SystemPreferencesType.alarmSoundLevelV20 = 8
SystemPreferencesType.hideSecretRecords = 8
SystemPreferencesType.deviceLocked = 8
SystemPreferencesType.localSyncRequiresPassword = 8
SystemPreferencesType.remoteSyncRequiresPassword = 8
SystemPreferencesType.pad = 8
SystemPreferencesType.sysPrefFlags = 8
SystemPreferencesType.sysBatteryKind = 10
SystemPreferencesType.pad2 = 10
SystemPreferencesType.minutesWestOfGMT = 10
SystemPreferencesType.daylightSavings = 14
SystemPreferencesType.pad3 = 14
SystemPreferencesType.romanaticChar = 14
SystemPreferencesType.hard1CharAppCreator = 16
SystemPreferencesType.hard2CharAppCreator = 20
SystemPreferencesType.hard3CharAppCreator = 24
SystemPreferencesType.hard4CharAppCreator = 28
SystemPreferencesType.calcCharAppCreator = 32
SystemPreferencesType.hardCradleCharAppCreator = 36
SystemPreferencesType.launcherCharAppCreator = 40
SystemPreferencesType.hardCradle2CharAppCreator = 44
SystemPreferencesType.animationLevel = 48
SystemPreferencesType.pad4 = 48
SystemPreferencesType.sysSoundVolume = 48
SystemPreferencesType.gameSoundVolume = 50
SystemPreferencesType.alarmSoundVolume = 52
SystemPreferencesType.beamReceive = 54
SystemPreferencesType.calibrateDigitizerAtReset = 54
SystemPreferencesType.systemKeyboardID = 54
SystemPreferencesType.defSerialPlugIn = 56
			| Hardware\M68328Hwr.h
HwrDBallType.scr = 0
HwrDBallType.filler1.2 = 0
HwrDBallType.csAGroupBase = 0
HwrDBallType.csBGroupBase = 2
HwrDBallType.csCGroupBase = 4
HwrDBallType.csDGroupBase = 6
HwrDBallType.csAGroupMask = 8
HwrDBallType.csBGroupMask = 10
HwrDBallType.csCGroupMask = 12
HwrDBallType.csDGroupMask = 14
HwrDBallType.csASelect0 = 16
HwrDBallType.csASelect1 = 20
HwrDBallType.csASelect2 = 24
HwrDBallType.csASelect3 = 28
HwrDBallType.csBSelect0 = 32
HwrDBallType.csBSelect1 = 36
HwrDBallType.csBSelect2 = 40
HwrDBallType.csBSelect3 = 44
HwrDBallType.csCSelect0 = 48
HwrDBallType.csCSelect1 = 52
HwrDBallType.csCSelect2 = 56
HwrDBallType.csCSelect3 = 60
HwrDBallType.csDSelect0 = 64
HwrDBallType.csDSelect1 = 68
HwrDBallType.csDSelect2 = 72
HwrDBallType.csDSelect3 = 76
HwrDBallType.csDebug = 80
HwrDBallType.filler2.1 = 82
HwrDBallType.pllControl = 82
HwrDBallType.pllFreqSel = 84
HwrDBallType.pllTest = 86
HwrDBallType.filler44 = 88
HwrDBallType.pwrControl = 88
HwrDBallType.filler3.2 = 88
HwrDBallType.intVector = 88
HwrDBallType.filler4 = 90
HwrDBallType.intControl = 90
HwrDBallType.intMaskHi = 92
HwrDBallType.intMaskLo = 94
HwrDBallType.intWakeupEnHi = 96
HwrDBallType.intWakeupEnLo = 98
HwrDBallType.intStatusHi = 100
HwrDBallType.intStatusLo = 102
HwrDBallType.intPendingHi = 104
HwrDBallType.intPendingLo = 106
HwrDBallType.filler4a.2 = 108
HwrDBallType.portADir = 108
HwrDBallType.portAData = 108
HwrDBallType.filler5 = 108
HwrDBallType.portASelect = 108
HwrDBallType.filler6 = 108
HwrDBallType.portBDir = 108
HwrDBallType.portBData = 108
HwrDBallType.filler7 = 108
HwrDBallType.portBSelect = 108
HwrDBallType.filler8 = 108
HwrDBallType.portCDir = 108
HwrDBallType.portCData = 108
HwrDBallType.filler9 = 108
HwrDBallType.portCSelect = 108
HwrDBallType.filler10 = 108
HwrDBallType.portDDir = 108
HwrDBallType.portDData = 108
HwrDBallType.portDPullupEn = 108
HwrDBallType.filler11 = 108
HwrDBallType.portDPolarity = 108
HwrDBallType.portDIntReqEn = 108
HwrDBallType.filler12 = 110
HwrDBallType.portDIntEdge = 110
HwrDBallType.portEDir = 112
HwrDBallType.portEData = 112
HwrDBallType.portEPullupEn = 112
HwrDBallType.portESelect = 112
HwrDBallType.filler14 = 112
HwrDBallType.portFDir = 112
HwrDBallType.portFData = 112
HwrDBallType.portFPullupEn = 112
HwrDBallType.portFSelect = 112
HwrDBallType.filler16 = 112
HwrDBallType.portGDir = 112
HwrDBallType.portGData = 112
HwrDBallType.portGPullupEn = 112
HwrDBallType.portGSelect = 112
HwrDBallType.filler18 = 112
HwrDBallType.portJDir = 112
HwrDBallType.portJData = 112
HwrDBallType.filler19 = 112
HwrDBallType.portJSelect = 112
HwrDBallType.filler19a = 112
HwrDBallType.portKDir = 112
HwrDBallType.portKData = 112
HwrDBallType.portKPullupEn = 112
HwrDBallType.portKSelect = 112
HwrDBallType.filler21 = 112
HwrDBallType.portMDir = 112
HwrDBallType.portMData = 112
HwrDBallType.portMPullupEn = 112
HwrDBallType.portMSelect = 112
HwrDBallType.filler22 = 112
HwrDBallType.filler23.1 = 112
HwrDBallType.pwmControl = 112
HwrDBallType.pwmPeriod = 114
HwrDBallType.pwmWidth = 116
HwrDBallType.pwmCounter = 118
HwrDBallType.filler24.2 = 120
HwrDBallType.tmr1Control = 120
HwrDBallType.tmr1Prescaler = 122
HwrDBallType.tmr1Compare = 124
HwrDBallType.tmr1Capture = 126
HwrDBallType.tmr1Counter = 128
HwrDBallType.tmr1Status = 130
HwrDBallType.tmr2Control = 132
HwrDBallType.tmr2Prescaler = 134
HwrDBallType.tmr2Compare = 136
HwrDBallType.tmr2Capture = 138
HwrDBallType.tmr2Counter = 140
HwrDBallType.tmr2Status = 142
HwrDBallType.wdControl = 144
HwrDBallType.wdReference = 146
HwrDBallType.wdCounter = 148
HwrDBallType.filler25.2 = 150
HwrDBallType.spiSlave = 150
HwrDBallType.filler26.2 = 152
HwrDBallType.spiMasterData = 152
HwrDBallType.spiMasterControl = 154
HwrDBallType.filler27.2 = 156
HwrDBallType.uControl = 156
HwrDBallType.uBaud = 158
HwrDBallType.uReceive = 160
HwrDBallType.uTransmit = 162
HwrDBallType.uMisc = 164
HwrDBallType.filler28.2 = 166
HwrDBallType.lcdStartAddr = 166
HwrDBallType.filler29 = 170
HwrDBallType.lcdPageWidth = 170
HwrDBallType.filler30 = 170
HwrDBallType.lcdScreenWidth = 170
HwrDBallType.lcdScreenHeight = 172
HwrDBallType.filler31. = 174
HwrDBallType.lcdCursorXPos = 174
HwrDBallType.lcdCursorYPos = 176
HwrDBallType.lcdCursorWidthHeight = 178
HwrDBallType.filler32 = 180
HwrDBallType.lcdBlinkControl = 180
HwrDBallType.lcdPanelControl = 180
HwrDBallType.lcdPolarity = 182
HwrDBallType.filler33 = 182
HwrDBallType.lcdACDRate = 182
HwrDBallType.filler34 = 182
HwrDBallType.lcdPixelClock = 182
HwrDBallType.filler35 = 182
HwrDBallType.lcdClockControl = 182
HwrDBallType.filler36 = 182
HwrDBallType.lcdLastBufferAddr = 182
HwrDBallType.filler37 = 182
HwrDBallType.lcdOctetTermCount = 182
HwrDBallType.filler38 = 182
HwrDBallType.lcdPanningOffset = 182
HwrDBallType.filler39 = 182
HwrDBallType.lcdFrameRate = 182
HwrDBallType.lcdGrayPalette = 182
HwrDBallType.lcdReserved = 184
HwrDBallType.filler40.2 = 184
HwrDBallType.rtcHourMinSec = 184
HwrDBallType.rtcAlarm = 188
HwrDBallType.rtcReserved = 192
HwrDBallType.rtcControl = 196
HwrDBallType.rtcIntStatus = 198
HwrDBallType.rtcIntEnable = 200
HwrDBallType.stopWatch = 202
hwr328LcdCursorXPosCtlMask	=	0xC000
hwr328LcdCursorXPosCtlTrans	=	0x0000
hwr328LcdCursorXPosCtlBlack	=	0x4000
hwr328LcdCursorXPosCtlReverse	=	0x8000
hwr328LcdBlinkControlEnable	=	0x80
hwr328LcdPanelControlBusMask	=	0x06
hwr328LcdPanelControlBus1Bit	=	0x00
hwr328LcdPanelControlBus2Bit	=	0x02
hwr328LcdPanelControlBus4Bit	=	0x04
hwr328LcdPanelControlGrayScale	=	0x01
hwr328LcdPolarityShiftClock	=	0x08
hwr328LcdPolarityFLM	=	0x04
hwr328LcdPolarityLP	=	0x02
hwr328LcdPolarityPixel	=	0x01
hwr328LcdClockControlEnable	=	0x80
hwr328LcdClockControl16WordBursts	=	0x40
hwr328LcdClockControlBurstRateMask	=	0x30
hwr328LcdClockControlBurstRate1	=	0x00
hwr328LcdClockControlBurstRate2	=	0x04
hwr328LcdClockControlBurstRate3	=	0x08
hwr328LcdClockControlBurstRate4	=	0x0C
hwr328LcdClockControlBurstRate5	=	0x10
hwr328LcdClockControlBurstRate6	=	0x14
hwr328LcdClockControlBurstRate7	=	0x18
hwr328LcdClockControlBurstRate8	=	0x1C
hwr328LcdClockControlBurstRate9	=	0x20
hwr328LcdClockControlBurstRate10	=	0x24
hwr328LcdClockControlBurstRate11	=	0x28
hwr328LcdClockControlBurstRate12	=	0x2C
hwr328LcdClockControlBurstRate13	=	0x30
hwr328LcdClockControlBurstRate14	=	0x34
hwr328LcdClockControlBurstRate15	=	0x38
hwr328LcdClockControlBurstRate16	=	0x3C
hwr328LcdClockControl8BitBus	=	0x02
hwr328LcdClockControlPixelClkSrc	=	0x01
hwr328IntHiNMI	=	0x0080
hwr328IntHiTimer1	=	0x0040
hwr328IntHiSPIS	=	0x0020
hwr328IntHiPen	=	0x0010
hwr328IntHiIRQ6	=	0x0008
hwr328IntHiIRQ3	=	0x0004
hwr328IntHiIRQ2	=	0x0002
hwr328IntHiIRQ1	=	0x0001
hwr328IntHiIRQ6Clr	=	0x0001
hwr328IntHiIRQ3Clr	=	0x0002
hwr328IntHiIRQ2Clr	=	0x0004
hwr328IntHiIRQ1Clr	=	0x0008
hwr328IntLoInt7	=	0x8000
hwr328IntLoInt6	=	0x4000
hwr328IntLoInt5	=	0x2000
hwr328IntLoInt4	=	0x1000
hwr328IntLoInt3	=	0x0800
hwr328IntLoInt2	=	0x0400
hwr328IntLoInt1	=	0x0200
hwr328IntLoInt0	=	0x0100
hwr328IntLoAllKeys	=	0xFF00
hwr328IntLoInt0Bit	=	8
hwr328IntLoPWM	=	0x0080
hwr328IntLoPWMBit	=	7
hwr328IntLoKbd	=	0x0040
hwr328IntLoLCDC	=	0x0020
hwr328IntLoRTC	=	0x0010
hwr328IntLoRTCBit	=	4
hwr328IntLoWDT	=	0x0008
hwr328IntLoUART	=	0x0004
hwr328IntLoUARTBit	=	2
hwr328IntLoTimer2	=	0x0002
hwr328IntLoTimer2Bit	=	1
hwr328IntLoSPIM	=	0x0001
hwr328IntCtlEdge1	=	0x0800
hwr328IntCtlEdge2	=	0x0400
hwr328IntCtlEdge3	=	0x0200
hwr328IntCtlEdge6	=	0x0100
hwr328IntCtlPol1	=	0x8000
hwr328IntCtlPol2	=	0x4000
hwr328IntCtlPol3	=	0x2000
hwr328IntCtlPol6	=	0x1000
hwr328TmrControlUnused	=	0xFE00
hwr328TmrControlFreeRun	=	0x0100
hwr328TmrControlCaptureEdgeMask	=	0x00C0
hwr328TmrControlCaptureEdgeNone	=	0x0000
hwr328TmrControlCaptureEdgeRising	=	0x0040
hwr328TmrControlCaptureEdgeFalling	=	0x0080
hwr328TmrControlCaptureEdgeBoth	=	0x00C0
hwr328TmrControlOutputModeToggle	=	0x0020
hwr328TmrControlEnInterrupt	=	0x0010
hwr328TmrControlClkSrcMask	=	0x000E
hwr328TmrControlClkSrcStop	=	0x0000
hwr328TmrControlClkSrcSys	=	0x0002
hwr328TmrControlClkSrcSysBy16	=	0x0004
hwr328TmrControlClkSrcTIN	=	0x0006
hwr328TmrControlClkSrc32KHz	=	0x0008
hwr328TmrControlEnable	=	0x0001
hwr328TmrStatusCapture	=	0x0002
hwr328TmrStatusCaptureBit	=	1
hwr328TmrStatusCompare	=	0x0001
hwr328TmrStatusCompareBit	=	0
hwr328UControlUARTEnable	=	0x8000
hwr328UControlRxEnable	=	0x4000
hwr328UControlTxEnable	=	0x2000
hwr328UControlRxClock1x	=	0x1000
hwr328UControlParityEn	=	0x0800
hwr328UControlParityOdd	=	0x0400
hwr328UControlStopBits2	=	0x0200
hwr328UControlDataBits8	=	0x0100
hwr328UControlGPIODeltaEn	=	0x0080
hwr328UControlCTSDeltaEn	=	0x0040
hwr328UControlRxFullEn	=	0x0020
hwr328UControlRxHalfEn	=	0x0010
hwr328UControlRxRdyEn	=	0x0008
hwr328UControlTxEmptyEn	=	0x0004
hwr328UControlTxHalfEn	=	0x0002
hwr328UControlTxAvailEn	=	0x0001
hwr328UControlEnableAll	=	hwr328UControlUARTEnable|hwr328UControlRxEnable|hwr328UControlTxEnable
hwr328UBaudGPIODelta	=	0x8000
hwr328UBaudGPIOData	=	0x4000
hwr328UBaudGPIODirOut	=	0x2000
hwr328UBaudGPIOSrcBaudGen	=	0x1000
hwr328UBaudBaudSrcGPIO	=	0x0800
hwr328UBaudDivider	=	0x0700
hwr328UBaudPrescaler	=	0x003F
hwr328UBaudDivideBitOffset	=	8
hwr328UReceiveFIFOFull	=	0x8000
hwr328UReceiveFIFOHalf	=	0x4000
hwr328UReceiveDataRdy	=	0x2000
hwr328UReceiveDataRdyBit	=	13
hwr328UReceiveOverrunErr	=	0x0800
hwr328UReceiveOverrunErrBit	=	11
hwr328UReceiveFrameErr	=	0x0400
hwr328UReceiveFrameErrBit	=	10
hwr328UReceiveBreakErr	=	0x0200
hwr328UReceiveBreakErrBit	=	9
hwr328UReceiveParityErr	=	0x0100
hwr328UReceiveParityErrBit	=	8
hwr328UReceiveData	=	0x00FF
hwr328UReceiveErrsMask	=	hwr328UReceiveOverrunErr|hwr328UReceiveFrameErr|hwr328UReceiveBreakErr|hwr328UReceiveParityErr
hwr328UTransmitFIFOEmpty	=	0x8000
hwr328UTransmitFIFOHalf	=	0x4000
hwr328UTransmitTxAvail	=	0x2000
hwr328UTransmitSendBreak	=	0x1000
hwr328UTransmitIgnoreCTS	=	0x0800
hwr328UTransmitCTSStatus	=	0x0200
hwr328UTransmitCTSDelta	=	0x0100
hwr328UTransmitData	=	0x00FF
hwr328UMiscClkSrcGPIO	=	0x4000
hwr328UMiscForceParityErr	=	0x2000
hwr328UMiscLoopback	=	0x1000
hwr328UMiscReservedMask	=	0x8F00
hwr328UMiscRTSThruFIFO	=	0x0080
hwr328UMiscRTSOut	=	0x0040
hwr328UMiscIRDAEn	=	0x0020
hwr328UMiscLoopIRDA	=	0x0010
hwr328UMiscUnused	=	0x000F
hwr328PWMControlEnable	=	0x0010
hwr328PWMControlEnableBit	=	4
hwr328PWMControlEnableIRQ	=	0x4000
hwr328PWMControlLoad	=	0x0100
hwr328PWMIRQStatus	=	0x8000
hwr328PWMControlDivMask	=	0x0007
hwr328PWMControlDivBy2	=	0x0
hwr328PWMControlDivBy4	=	0x1
hwr328PWMControlDivBy8	=	0x2
hwr328PWMControlDivBy16	=	0x3
hwr328PWMControlDivBy32	=	0x4
hwr328PWMControlDivBy64	=	0x5
hwr328PWMControlDivBy128	=	0x6
hwr328PWMControlDivBy256	=	0x7
hwr328PLLControlDisable	=	0x0008
hwr328PLLControlClkEn	=	0x0010
hwr328PLLControlSysVCODiv2	=	0x0000
hwr328PLLControlSysVCODiv4	=	0x0100
hwr328PLLControlSysVCODiv8	=	0x0200
hwr328PLLControlSysVCODiv16	=	0x0300
hwr328PLLControlSysVCODiv1	=	0x0400
hwr328PLLControlPixVCODiv2	=	0x0000
hwr328PLLControlPixVCODiv4	=	0x080
hwr328PLLControlPixVCODiv8	=	0x1000
hwr328PLLControlPixVCODiv16	=	0x1800
hwr328PLLControlPixVCODiv1	=	0x2000
hwr328RTCControlRTCEnable	=	0x80
hwr328RTCControlRefSelMask	=	0x20
hwr328RTCControlRefSel38400	=	0x20
hwr328RTCControlRefSel32768	=	0x00
hwr328RTCIntEnableSec	=	0x10
hwr328RTCIntEnable24Hr	=	0x08
hwr328RTCIntEnableAlarm	=	0x04
hwr328RTCIntEnableMinute	=	0x02
hwr328RTCIntEnableStopWatch	=	0x01
hwr328RTCIntStatusSec	=	0x10
hwr328RTCIntStatus24Hr	=	0x08
hwr328RTCIntStatusAlarm	=	0x04
hwr328RTCIntStatusMinute	=	0x02
hwr328RTCIntStatusStopWatch	=	0x01
hwr328RTCAlarmSecondsMask	=	0x0000003f
hwr328RTCAlarmSecondsOffset	=	0
hwr328RTCAlarmMinutesMask	=	0x003f0000
hwr328RTCAlarmMinutesOffset	=	16
hwr328RTCAlarmHoursMask	=	0x1f000000
hwr328RTCAlarmHoursOffset	=	24
hwr328RTCHourMinSecSecondsMask	=	0x0000003f
hwr328RTCHourMinSecSecondsOffset	=	0
hwr328RTCHourMinSecMinutesMask	=	0x003f0000
hwr328RTCHourMinSecMinutesOffset	=	16
hwr328RTCHourMinSecHoursMask	=	0x1f000000
hwr328RTCHourMinSecHoursOffset	=	24
hwr328SPIMControlRateMask	=	0xE000
hwr328SPIMControlRateDiv4	=	0x0000
hwr328SPIMControlRateDiv8	=	0x2000
hwr328SPIMControlRateDiv16	=	0x4000
hwr328SPIMControlRateDiv32	=	0x6000
hwr328SPIMControlRateDiv64	=	0x8000
hwr328SPIMControlRateDiv128	=	0xA000
hwr328SPIMControlRateDiv256	=	0xC000
hwr328SPIMControlRateDiv512	=	0xE000
hwr328SPIMControlEnable	=	0x0200
hwr328SPIMControlExchange	=	0x0100
hwr328SPIMControlIntStatus	=	0x0080
hwr328SPIMControlIntEnable	=	0x0040
hwr328SPIMControlOppPhase	=	0x0020
hwr328SPIMControlInvPolarity	=	0x0010
hwr328SPIMControlBitsMask	=	0x000F
hwr328PortCMOClk	=	0x01
hwr328PortCUDS	=	0x02
hwr328PortCLDS	=	0x04
hwr328PortCNMI	=	0x10
hwr328PortCDTack	=	0x20
hwr328PortCPcmciaWE	=	0x40
hwr328PortGUartTxD	=	0x01
hwr328PortGUartRxD	=	0x02
hwr328PortGPwmOut	=	0x04
hwr328PortGTOut2	=	0x08
hwr328PortGTIn2	=	0x10
hwr328PortGTOut1	=	0x20
hwr328PortGTIn1	=	0x40
hwr328PortGRtcOut	=	0x80
hwr328PortKSpimTxD	=	0x01
hwr328PortKSpimRxD	=	0x02
hwr328PortKSpimClkO	=	0x04
hwr328PortKSpisEn	=	0x08
hwr328PortKSpisRxD	=	0x10
hwr328PortKSpisClkI	=	0x20
hwr328PortKPcmciaCE2	=	0x40
hwr328PortKPcmciaCE1	=	0x80
hwr328PortMCTS	=	0x01
hwr328PortMRTS	=	0x02
hwr328PortMIRQ6	=	0x04
hwr328PortMIRQ3	=	0x08
hwr328PortMIRQ2	=	0x10
hwr328PortMIRQ1	=	0x20
hwr328PortMPenIRQ	=	0x40
hwr328PortMUnused7	=	0x80
			| Hardware\M68681Hwr.h
read.mra = 0
read.u0 = 0
read.sra = 0
read.u2 = 0
read.doNotAccess1 = 0
read.u4 = 0
read.rba = 0
read.u6 = 0
read.ipcr = 0
read.u8 = 0
read.isr = 0
read.uA = 0
read.cur = 0
read.uC = 0
read.clr = 0
read.uE = 0
read.mrb = 0
read.u10 = 0
read.srb = 0
read.u12 = 0
read.doNotAccess2 = 0
read.u14 = 0
read.rbb = 0
read.u16 = 0
read.ivr = 0
read.u18 = 2
read.ipr = 2
read.u1A = 2
read.startCtr = 2
read.u1C = 2
read.stopCtr = 2
read.u1E = 2
write.mra = 0
write.u0 = 0
write.csra = 0
write.u2 = 0
write.cra = 0
write.u4 = 0
write.tba = 0
write.u6 = 0
write.acr = 0
write.u8 = 0
write.imr = 0
write.uA = 2
write.ctur = 2
write.uC = 2
write.ctlr = 2
write.uE = 2
write.mrb = 2
write.u10 = 2
write.csrb = 2
write.u12 = 2
write.crb = 2
write.u14 = 2
write.tbb = 2
write.u16 = 2
write.ivr = 2
write.u18 = 4
write.opcr = 4
write.u1A = 4
write.opSet = 4
write.u1C = 4
write.opReset = 4
write.u1E = 4
hwrDuartSRRegRB	=	0x80
hwrDuartSRRegFE	=	0x40
hwrDuartSRRegPE	=	0x20
hwrDuartSRRegOE	=	0x10
hwrDuartSRRegTxEMP	=	0x08
hwrDuartSRRegTxRDY	=	0x04
hwrDuartSRRegFFULL	=	0x02
hwrDuartSRRegRxRDY	=	0x01
			| Hardware\HardwareTD1.h
hwrTD1PortDNoExtPower	=	0x80
hwrTD1PortENoBacklight	=	0x80
hwrTD1PortFPanelYPOff	=	0x01
hwrTD1PortFPanelYMOn	=	0x02
hwrTD1PortFPanelXPOff	=	0x04
hwrTD1PortFPanelXMOn	=	0x08
hwrTD1PortFLCDEnableOn	=	0x10
hwrTD1PortFLCDVccOff	=	0x20
hwrTD1PortFLCDVeeOn	=	0x40
hwrTD1PortFADCSOff	=	0x80
hwrTD1PortFPanelMask	=	0x0F
hwrTD1PortFPanelCfgOff	=	hwrTD1PortFPanelYPOff|hwrTD1PortFPanelXPOff
hwrTD1PortFPanelCfgPenIRQ	=	hwrTD1PortFPanelXMOn|hwrTD1PortFPanelYPOff|hwrTD1PortFPanelXPOff
hwrTD1PortFPanelCfgYMeas	=	hwrTD1PortFPanelXMOn|hwrTD1PortFPanelYPOff
hwrTD1PortFPanelCfgXMeas	=	hwrTD1PortFPanelXPOff|hwrTD1PortFPanelYMOn
hwrTD1PortGSerialOn	=	0x08
hwrTD1PortGBattOff	=	0x10
hwrTD1PortGRefreshOut	=	0x20
hwrTD1PortGSelfRefOff	=	0x40
hwrTD1PortGSelfRefOffBit	=	6
hwrTD1PortGBacklightOn	=	0x80
hwrTD1PortJIrOn	=	0x10
hwrTD1PortJLedOn	=	0x20
hwrTD1PortMVccFail	=	0x04
hwrTD1PortMCardIRQ	=	0x08
hwrTD1PortMUnused4	=	0x10
hwrTD1PortMDockButton	=	0x20
hwrTD1PortMPenIO	=	0x40
hwrTD1PortMDockIn	=	0x80
hwrTD1SPIMBaseControl	=	hwr328SPIMControlRateDiv16|hwr328SPIMControlIntEnable|hwr328SPIMControlInvPolarity|hwr328SPIMControlOppPhase|16-1
hwrTD1PLLControl	=	hwr328PLLControlClkEn|hwr328PLLControlSysVCODiv1|hwr328PLLControlPixVCODiv1
hwrTD1FreqSelQ	=	0x01
hwrTD1FreqSelP	=	0x23
hwrTD1Frequency	=	32768*((hwrTD1FreqSelP+1)*14+hwrTD1FreqSelQ+1)/1
			| Hardware\Hardware.h
hwrWakeUpGeneral	=	0x0001
hwrWakeUpPWM	=	0x0002
hwrWakeUpFromKey	=	0x0004
hwrWakeUpReturnToSleep	=	0x0008
hwrMiscFlagHasBacklight	=	0x0001
hwrMiscFlagHasMbdIrDA	=	0x0002
hwrMiscFlagHasCardIrDA	=	0x0004
hwrMiscFlagHasBurrBrown	=	0x0008
hwrMiscFlagHasJerryHW	=	0x0010
hwrMiscFlagID1	=	0x1000
hwrMiscFlagID2	=	0x2000
hwrMiscFlagID3	=	0x4000
hwrMiscFlagID4	=	0x8000
hwrMiscFlagIDMask	=	0xF000
hwrDockInSyncButton	=	0x0001
hwrDockInGeneric1	=	0x0002
hwrDockOutGeneric0	=	0x0001
hwrNumCardSlots	=	1
hwrDisplayWidth	=	160
hwrDisplayHeight	=	160
hwrDisplayBootDepth	=	1
hwrDisplayMaxDepth	=	2
hwrDisplayAllDepths	=	0x0003
hwrDisplayPeriod	=	12
hwrStepsPerVolt	=	78
hwrVoltStepsOffset	=	0
hwrSystemTop	=	(hwrDisplayHeight+4)
hwrSystemHeight	=	56
hwrGraffitiTop	=	hwrSystemTop
hwrGraffitiLeft	=	27
hwrGraffitiWidth	=	106
hwrGraffitiHeight	=	hwrSystemHeight
hwrGraffitiSplit	=	hwrGraffitiLeft+62
hwrLaunchBtnLeft	=	0
hwrLaunchBtnTop	=	hwrSystemTop
hwrLaunchBtnWidth	=	27
hwrLaunchBtnHeight	=	hwrSystemHeight/2
hwrMenuBtnWidth	=	27
hwrMenuBtnHeight	=	hwrSystemHeight/2
hwrMenuBtnLeft	=	0
hwrMenuBtnTop	=	hwrSystemTop+hwrMenuBtnHeight
hwrCalcBtnLeft	=	133
hwrCalcBtnTop	=	hwrSystemTop
hwrCalcBtnWidth	=	27
hwrCalcBtnHeight	=	hwrSystemHeight/2
hwrFindBtnLeft	=	133
hwrFindBtnTop	=	hwrSystemTop+hwrCalcBtnHeight
hwrFindBtnWidth	=	27
hwrFindBtnHeight	=	hwrSystemHeight/2
hwrKeyboardAlphaBtnLeft	=	27
hwrKeyboardAlphaBtnTop	=	(hwrSystemTop+hwrSystemHeight-hwrSystemHeight/4)
hwrKeyboardAlphaBtnWidth	=	18
hwrKeyboardAlphaBtnHeight	=	(hwrSystemHeight/4)
hwrKeyboardNumericBtnWidth	=	18
hwrKeyboardNumericBtnHeight	=	hwrKeyboardAlphaBtnHeight
hwrKeyboardNumericBtnLeft	=	hwrFindBtnLeft-hwrKeyboardNumericBtnWidth
hwrKeyboardNumericBtnTop	=	hwrKeyboardAlphaBtnTop
hwrLCDGetCurrentDepth	=	0
HwrROMTokenRec.token = 0
HwrROMTokenRec.len = 4
HwrROMTokenRec.data = 6
hwrROMTokenSnum	=	0x736e756d
hwrROMTokenIrda	=	0x69726461
hwrROMTokenFlex	=	0x666c6578
hwrROMTokenBoot1	=	0x63643031
hwrROMTokenBoot2	=	0x63643032
hwrROMTokenBoot3	=	0x63643033
			| Hardware\HardwarePrv.h
hwr68328Base	=	0xFFFFF000
hwrCardBase0	=	0x10000000
hwrCardSize	=	0x10000000
hwrFlashBase	=	0x10C00000
hwrFlashSize	=	0x00100000
hwrCardOffsetMask	=	0x0FFFFFFF
hwrROMWidth	=	2
hwrDuartBase	=	0x10E00000
hwrDuartClock	=	3686400
hwrDuartACRReg	=	0x60
			| System\AlarmMgr.h
almErrMemory	=	almErrorClass|1
almErrFull	=	almErrorClass|2
SysAlarmTriggeredParamType.ref = 0
SysAlarmTriggeredParamType.alarmSeconds = 4
SysAlarmTriggeredParamType.purgeAlarm = 8
SysAlarmTriggeredParamType.pad = 8
SysDisplayAlarmParamType.ref = 0
SysDisplayAlarmParamType.alarmSeconds = 4
SysDisplayAlarmParamType.soundAlarm = 8
SysDisplayAlarmParamType.pad = 8
			| System\AlarmPrv.h
almMinTableLength	=	2
almMaxTableLength	=	20
AlmEntryType.ref = 0
AlmEntryType.alarmSeconds = 4
AlmEntryType.dbID = 8
AlmEntryType.cardNo = 12
AlmEntryType.quiet = 14
AlmEntryType.triggered = 16
AlmEntryType.notified = 18
AlmTableType.numEntries = 0
AlmTableType.list. = 2
AlmGlobalsType.tableH = 0
AlmGlobalsType.lastSoundSeconds = 4
AlmGlobalsType.displaying = 8
AlmGlobalsType.triggered = 10
AlmGlobalsType.disableCount = 12
AlmGlobalsType.pad = 12
			| System\AppLaunchCmd.h
			| AddressLookupFields;
addrLookupName	=	0
addrLookupFirstName	=	1
addrLookupCompany	=	2
addrLookupAddress	=	3
addrLookupCity	=	4
addrLookupState	=	5
addrLookupZipCode	=	6
addrLookupCountry	=	7
addrLookupTitle	=	8
addrLookupCustom1	=	9
addrLookupCustom2	=	10
addrLookupCustom3	=	11
addrLookupCustom4	=	12
addrLookupNote	=	13
addrLookupWork	=	14
addrLookupHome	=	15
addrLookupFax	=	16
addrLookupOther	=	17
addrLookupEmail	=	18
addrLookupMain	=	19
addrLookupPager	=	20
addrLookupMobile	=	21
addrLookupSortField	=	22
addrLookupListPhone	=	23
addrLookupNoField	=	0xff
addrLookupStringLength	=	12
AddrLookupParamsType.title = 0
AddrLookupParamsType.pasteButtonText = 4
AddrLookupParamsType.lookupString. = 8
AddrLookupParamsType.field1 = 8
AddrLookupParamsType.field2 = 8
AddrLookupParamsType.field2Optional = 8
AddrLookupParamsType.userShouldInteract = 8
AddrLookupParamsType.formatStringP = 8
AddrLookupParamsType.resultStringH = 12
AddrLookupParamsType.uniqueID = 16
			|prefAppLaunchCmdSetActivePanel	equ	sysAppaunchCmdCustomBase + 1
PrefActivePanelParamsType.activePanel = 0
			| MailMsgPriorityType
mailPriorityHigh	=	0
mailPriorityNormal	=	1
mailPriorityLow	=	2
MailAddRecordParamsType.secret = 0
MailAddRecordParamsType.signature = 0
MailAddRecordParamsType.confirmRead = 0
MailAddRecordParamsType.confirmDelivery = 0
MailAddRecordParamsType.priority = 0
MailAddRecordParamsType.pad = 0
MailAddRecordParamsType.subject = 0
MailAddRecordParamsType.from = 4
MailAddRecordParamsType.to = 8
MailAddRecordParamsType.cc = 12
MailAddRecordParamsType.bcc = 16
MailAddRecordParamsType.replyTo = 20
MailAddRecordParamsType.body = 24
			| System\CMClient.h
cmErrParam	=	cmpErrorClass|1
cmErrTimeOut	=	cmpErrorClass|2
cmErrComm	=	cmpErrorClass|3
cmErrCommVersion	=	cmpErrorClass|4
cmErrMemory	=	cmpErrorClass|5
cmErrCommBusy	=	cmpErrorClass|6
cmErrUserCan	=	cmpErrorClass|7
cmWakeupTransactionID	=	0xFF
CmParamType.localSocket = 0
CmParamType.remoteSocket = 2
CmParamType.maxBaud = 4
CmParamType.viaModem = 8
CmParamType.abortProc = 8
CmParamType.userRef = 12
CmSessionType.param.CmParamTy = 0
CmSessionType.serRefNum = 0
			| System\CMCommon.h
			| CmpType
cmpWakeup	=	1
cmpInit	=	2
cmpAbort	=	3
cmpExtended	=	4
CmpBodyType.type = 0
CmpBodyType.flags = 0
CmpBodyType.verMajor = 0
CmpBodyType.verMinor = 0
CmpBodyType.wReserved = 0
CmpBodyType.commVersion = 2
CmpBodyType.baudRate = 6
cmpInitFlagChangeBaudRate	=	0x80
cmpInitFlagRcvTOut1Min	=	0x40
cmpInitFlagRcvTOut2Min	=	0x20
cmpAbortFlagVersionError	=	0x80
cmpWakeupTransactionID	=	0xFF
cmpInitialBaudRate	=	9600
cmpMaxInitiateSec	=	20
CmpCommandHeaderType.hdrType = 0
CmpCommandHeaderType.cmd = 0
CmpCommandHeaderType.errorCode = 0
CmpCommandHeaderType.argCount = 2
CmpCommandHeaderType.reserved1 = 2
CmpCommandHeaderType.reserved2 = 2
			|???typedef union CmpGenericCommandType {
			|???	Byte						hdrType;	;	;
			|???	;CmpBodyType				body10;
			|???	;CmpCommandHeaderType	exHdr;
			|???	;} CmpGenericCommandType;
			|???	;
			|???type def CmpGenericCommandType*		CmpGenericCommandPtr;
cmpRespBit	=	0x80
cmpCmdIDMask	=	0x7f
cmpFirstArgID	=	0x20
			| CmpRespErrEnum
cmpRespErrNone	=	0
cmpRespErrSystem	=	1
cmpRespErrUnknownCmd	=	2
cmpRespErrMemory	=	3
cmpRespErrParam	=	4
cmpRespErrLast	=	5
			| CmpCmdEnum
cmpCmdReserved	=	0x0F
cmpCmdXCommPrefs	=	0x10
cmpCmdHShakeComplete	=	0x11
cmpCmdLast	=	0x12
CmpCommPrefsType.maxPktDataSize = 0
CmpCommPrefsType.maxDataBlkSize = 4
CmpCommPrefsType.maxBaudRate = 8
CmpCommPrefsType.hwHShakeAbove = 12
CmpCommPrefsType.flags = 16
CmpCommPrefsType.version = 20
CmpCommPrefsType.reserved2 = 24
CmpCommPrefsType.reserved3 = 28
cmpCommPrefsFlagSupportPktCRC16	=	0x80000000
cmpCommPrefsFlagUsePktCRC16	=	0x00008000
cmpCommPrefsFlagSupportShortOffsets	=	0x40000000
cmpCommPrefsFlagUseShortOffsets	=	0x00004000
cmpCommPrefsFlagSupportLongOffsets	=	0x20000000
cmpCommPrefsFlagUseLongOffsets	=	0x00002000
cmpXCommPrefsReqArgID	=	cmpFirstArgID
CmpXCommPrefsReqType.prefs.CmpCommPrefsTy = 0
cmpXCommPrefsPrefsRespArgID	=	cmpFirstArgID
			|???	cmpXCommPrefsIPAddrRespArgID	equ	cmpFirstArgID + 1
CmpXCommPrefsPrefsRespType.prefs.CmpCommPrefsTy = 0
CmpXCommPrefsIPAddrRespType.ipAddr = 0
cmpHShakeCompleteReqArgID	=	cmpFirstArgID
CmpHShakeCompleteReqType.final.CmpCommPrefsTy = 0
			| System\CTP.h
			| CTPCmdEnum
ctpCmdReqURL	=	0
ctpCmdReqMail	=	1
ctpCmdEcho	=	2
ctpCmdMsgGen	=	3
ctpCmdDiscard	=	4
			| ctpConvEnum
ctpConvCML	=	0
ctpConvCML8Bit	=	1
ctpConvCMLLZSS	=	2
ctpConvNone	=	3
			| CTPReqExtEnum
ctpExtIncHTTPResponse	=	1
ctpExtNetID	=	128
ctpExtUserID	=	129
ctpExtUserPW	=	130
ctpExtUserName	=	131
ctpExtServer	=	132
ctpExtConvertTo	=	133
			| CTPRspExtURLEnum
ctpExtContentType	=	128
ctpExtContentEncoding	=	129
ctpExtUncompressSize	=	130
			| CTPNetIDEnum
ctpNetIDMobitex	=	0
ctpNetIDUnknown	=	0xFFFF
			| CTPSchemeEnum
ctpSchemeHTTP	=	0
ctpSchemeHTTPS	=	1
ctpSchemeFTP	=	2
ctpSchemeEmpty	=	7
			| CTPErrEnum
ctpErrNone	=	0
ctpErrMalformedRequest	=	1
ctpErrUnknownCmd	=	2
ctpErrProxy	=	3
ctpErrServer	=	4
ctpErrTruncated	=	0x8000
			| System\DataMgr.h
dmRecAttrCategoryMask	=	0x0F
dmRecNumCategories	=	16
dmCategoryLength	=	16
dmAllCategories	=	0xff
dmUnfiledCategory	=	0
dmMaxRecordIndex	=	0xffff
dmRecAttrDelete	=	0x80
dmRecAttrDirty	=	0x40
dmRecAttrBusy	=	0x20
dmRecAttrSecret	=	0x10
dmAllRecAttrs	=	dmRecAttrDelete|dmRecAttrDirty|dmRecAttrBusy|dmRecAttrSecret
dmSysOnlyRecAttrs	=	dmRecAttrBusy
dmDBNameLength	=	32
dmHdrAttrResDB	=	0x0001
dmHdrAttrReadOnly	=	0x0002
dmHdrAttrAppInfoDirty	=	0x0004
dmHdrAttrBackup	=	0x0008
dmHdrAttrOKToInstallNewer	=	0x0010
dmHdrAttrResetAfterInstall	=	0x0020
dmHdrAttrCopyPrevention	=	0x0040
dmHdrAttrStream	=	0x0080
dmHdrAttrOpen	=	0x8000
dmAllHdrAttrs	=	dmHdrAttrResDB|dmHdrAttrReadOnly|dmHdrAttrAppInfoDirty|dmHdrAttrBackup|dmHdrAttrOKToInstallNewer|dmHdrAttrResetAfterInstall|dmHdrAttrCopyPrevention|dmHdrAttrStream|dmHdrAttrOpen)
dmSysOnlyHdrAttrs	=	dmHdrAttrResDB|dmHdrAttrOpen)
dmRecordIDReservedRange	=	1
dmDefaultRecordsID	=	0
dmUnusedRecordID	=	0
dmModeReadOnly	=	0x0001
dmModeWrite	=	0x0002
dmModeReadWrite	=	0x0003
dmModeLeaveOpen	=	0x0004
dmModeExclusive	=	0x0008
dmModeShowSecret	=	0x0010
DmSearchStateType.info. = 0
SortRecordInfoType.attributes = 0
SortRecordInfoType.uniqueID = 0
dmErrMemError	=	dmErrorClass|1
dmErrIndexOutOfRange	=	dmErrorClass|2
dmErrInvalidParam	=	dmErrorClass|3
dmErrReadOnly	=	dmErrorClass|4
dmErrDatabaseOpen	=	dmErrorClass|5
dmErrCantOpen	=	dmErrorClass|6
dmErrCantFind	=	dmErrorClass|7
dmErrRecordInWrongCard	=	dmErrorClass|8
dmErrCorruptDatabase	=	dmErrorClass|9
dmErrRecordDeleted	=	dmErrorClass|10
dmErrRecordArchived	=	dmErrorClass|11
dmErrNotRecordDB	=	dmErrorClass|12
dmErrNotResourceDB	=	dmErrorClass|13
dmErrROMBased	=	dmErrorClass|14
dmErrRecordBusy	=	dmErrorClass|15
dmErrResourceNotFound	=	dmErrorClass|16
dmErrNoOpenDatabase	=	dmErrorClass|17
dmErrInvalidCategory	=	dmErrorClass|18
dmErrNotValidRecord	=	dmErrorClass|19
dmErrWriteOutOfBounds	=	dmErrorClass|20
dmErrSeekFailed	=	dmErrorClass|21
dmErrAlreadyOpenForWrites	=	dmErrorClass|22
dmErrOpenedByAnotherTask	=	dmErrorClass|23
dmErrUniqueIDNotFound	=	dmErrorClass|24
dmErrAlreadyExists	=	dmErrorClass|25
dmErrInvalidDatabaseName	=	dmErrorClass|26
dmErrDatabaseProtected	=	dmErrorClass|27
dmSeekForward	=	1
dmSeekBackward	=	-1
			| System\DataPrv.h
RecordEntryType.localChunkID = 0
RecordEntryType.attributes = 4
RecordEntryType.uniqueID = 4
RsrcEntryType.type = 0
RsrcEntryType.id = 4
RsrcEntryType.localChunkID = 6
dmRsrcAttrUnused	=	0x0000
RecordListType.nextRecordListID = 0
RecordListType.numRecords = 4
RecordListType.firstEntry = 6
DatabaseHdrType.name. = 0
DatabaseHdrType.attributes = 0
DatabaseHdrType.version = 2
DatabaseHdrType.creationDate = 4
DatabaseHdrType.modificationDate = 8
DatabaseHdrType.lastBackupDate = 12
DatabaseHdrType.modificationNumber = 16
DatabaseHdrType.appInfoID = 20
DatabaseHdrType.sortInfoID = 24
DatabaseHdrType.type = 28
DatabaseHdrType.creator = 32
DatabaseHdrType.uniqueIDSeed = 36
DatabaseHdrType.recordList.RecordListTy = 40
DatabaseDirType.nextDatabaseListID = 0
DatabaseDirType.numDatabases = 4
DatabaseDirType.databaseID = 6
DmOpenInfoType.next = 0
DmOpenInfoType.openCount = 4
DmOpenInfoType.ownerTaskID = 6
DmOpenInfoType.exclusive = 10
DmOpenInfoType.writeAccess = 12
DmOpenInfoType.resDB = 14
DmOpenInfoType.hdrID = 16
DmOpenInfoType.hdrH = 20
DmOpenInfoType.hdrP = 24
DmOpenInfoType.cardNo = 28
DmOpenInfoType.numRecords = 30
DmOpenInfoType.hdrMasterP = 32
DmOpenInfoType.handleTableP = 36
DmAccessType.next = 0
DmAccessType.mode = 4
DmAccessType.openP = 6
DmAccessType.savedModNum = 10
DmPrvSearchStateType.index = 0
DmPrvSearchStateType.relIndex = 2
DmPrvSearchStateType.cardNo = 4
DmPrvSearchStateType.storeNo = 4
DmPrvSearchStateType.storeEntries = 4
DmPrvSearchStateType.storeStartIndex = 6
DmPrvSearchStateType.dirID = 8
DmProtectEntryType.protectCount = 0
DmProtectEntryType.cardNo = 0
DmProtectEntryType.dbID = 0
dmDynOwnerID	=	0x00
dmMgrOwnerID	=	0x01
dmRecOwnerID	=	0x02
dmOrphanOwnerID	=	0x03
			| System\DateTime.h
DateTimeType.second = 0
DateTimeType.minute = 2
DateTimeType.hour = 4
DateTimeType.day = 6
DateTimeType.month = 8
DateTimeType.year = 10
DateTimeType.weekDay = 12
TimeType.hours = 0
TimeType.minutes = 0
noTime	=	-1
DateType.year = 0
DateType.month = 2
DateType.day = 4
timeStringLength	=	9
dateStringLength	=	9
longDateStrLength	=	15
firstYear	=	1904
numberOfYears	=	128
lastYear	=	firstYear+numberOfYears-1
minutesInSeconds	=	60
hoursInMinutes	=	60
hoursInSeconds	=	hoursInMinutes*minutesInSeconds
hoursPerDay	=	24
daysInSeconds	=	0x15180
daysInWeek	=	7
daysInYear	=	365
daysInLeapYear	=	366
daysInFourYears	=	daysInLeapYear+3*daysInYear
monthsInYear	=	12
maxDays	=	numberOfYears/4*daysInFourYears-1
maxSeconds	=	maxDays*daysInSeconds
maxTime	=	0x0
sunday	=	0
monday	=	1
tuesday	=	2
wednesday	=	3
thursday	=	4
friday	=	5
saturday	=	6
january	=	1
february	=	2
march	=	3
april	=	4
may	=	5
june	=	6
july	=	7
august	=	8
september	=	9
october	=	10
november	=	11
december	=	12
			| DayOfWeekType
dom1stSun	=	0
dom1stMon	=	1
dom1stTue	=	2
dom1stWen	=	3
dom1stThu	=	4
dom1stFri	=	5
dom1stSat	=	6
dom2ndSun	=	7
dom2ndMon	=	8
dom2ndTue	=	9
dom2ndWen	=	10
dom2ndThu	=	11
dom2ndFri	=	12
dom2ndSat	=	13
dom3rdSun	=	14
dom3rdMon	=	15
dom3rdTue	=	16
dom3rdWen	=	17
dom3rdThu	=	18
dom3rdFri	=	19
dom3rdSat	=	20
dom4thSun	=	21
dom4thMon	=	22
dom4thTue	=	23
dom4thWen	=	24
dom4thThu	=	25
dom4thFri	=	26
dom4thSat	=	27
domLastSun	=	28
domLastMon	=	29
domLastTue	=	30
domLastWen	=	31
domLastThu	=	32
domLastFri	=	33
domLastSat	=	34
			| System\DebugMgr.h
dbgCtlNotHandled	=	false
dbgCtlHandled	=	true
dbgCtlAllHandlersID	=	0
dbgCtlHandlerNameLen	=	31
dbgCtlHandlerVerLen	=	15
dbgCtlFirstCustomOp	=	0x8000
DbgCtlHandlerInfoType.handlerFuncP = 0
DbgCtlHandlerInfoType.version = 4
DbgCtlHandlerInfoType.enabled = 8
DbgCtlHandlerInfoType.pad = 8
DbgCtlHandlerInfoType.name. = 8
DbgCtlHandlerInfoType.ver. = 8
DbgCtlHandlerInfoType.dwReserved = 8
DbgCtlEnumInfoType.enumFuncP = 0
DbgCtlEnumInfoType.callbackDataP = 4
dbgCtlOpEnumHandlers	=	1
dbgCtlOpGetHandlerInfo	=	2
dbgCtlOpEnableHandler	=	3
dbgCtlOpDisableHandler	=	4
dbgCtlOpGetEnabledStatus	=	5
dbgCtlOpGetVersion	=	6
dbgCtlOpLAST	=	7
			| System\ExgMgr.h
exgMemError	=	exgErrorClass|1
exgErrStackInit	=	exgErrorClass|2
exgErrUserCancel	=	exgErrorClass|3
exgErrNoReceiver	=	exgErrorClass|4
exgErrNoKnownTarget	=	exgErrorClass|5
exgErrTargetMissing	=	exgErrorClass|6
exgErrNotAllowed	=	exgErrorClass|7
exgErrBadData	=	exgErrorClass|8
exgErrAppError	=	exgErrorClass|9
exgErrUnknown	=	exgErrorClass|10
exgErrDeviceFull	=	exgErrorClass|11
exgErrDisconnected	=	exgErrorClass|12
exgErrNotFound	=	exgErrorClass|13
exgErrBadParam	=	exgErrorClass|14
exgErrNotSupported	=	exgErrorClass|15
exgErrDeviceBusy	=	exgErrorClass|16
exgErrBadLibrary	=	exgErrorClass|17
ExgGoToType.dbCardNo = 0
ExgGoToType.dbID = 2
ExgGoToType.recordNum = 6
ExgGoToType.uniqueID = 8
ExgGoToType.matchCustom = 12
ExgSocketType.libraryRef = 0
ExgSocketType.socketRef = 2
ExgSocketType.target = 6
ExgSocketType.count = 10
ExgSocketType.length = 14
ExgSocketType.time = 18
ExgSocketType.appData = 22
ExgSocketType.goToCreator = 26
ExgSocketType.goToParams.ExgGoToTy = 30
ExgSocketType.flags = 30
ExgSocketType.description = 32
ExgSocketType.type = 36
ExgSocketType.name = 40
			|	localMode:1.w
			|	packetMode:1.w
			|	reserved:14.w
ExgAskParamType.socketP = 0
ExgAskParamType.result = 4
exgSeparatorChar	=	0x5c74
exgRegLibraryID	=	0xfffc
exgRegExtensionID	=	0xfffd
exgRegTypeID	=	0xfffe
exgDataPrefVersion	=	0
exgMaxTitleLen	=	20
exgLibCtlGetTitle	=	1
exgLibCtlSpecificOp	=	0x8000
			| System\ErrorMgr.h
ErrExceptionType.nextP = 0
ErrExceptionType.state. = 4
ErrExceptionType.err = 4
			| System\ExgLib.h
exgIntDataChr	=	0x01ff
			| ExgLibTrapNumberEnum
exgLibTrapHandleEvent	=	sysLibTrapCustom
exgLibTrapConnect	=	sysLibTrapCustom+1
exgLibTrapAccept	=	sysLibTrapCustom+2
exgLibTrapDisconnect	=	sysLibTrapCustom+3
exgLibTrapPut	=	sysLibTrapCustom+4
exgLibTrapGet	=	sysLibTrapCustom+5
exgLibTrapSend	=	sysLibTrapCustom+6
exgLibTrapReceive	=	sysLibTrapCustom+7
exgLibTrapControl	=	sysLibTrapCustom+8
exgLibReserved1	=	sysLibTrapCustom+9
exgLibTrapLast	=	sysLibTrapCustom+10
			| System\FeatureMgr.h
ftrErrInvalidParam	=	ftrErrorClass|1
ftrErrNoSuchFeature	=	ftrErrorClass|2
ftrErrAlreadyExists	=	ftrErrorClass|3
ftrErrROMBased	=	ftrErrorClass|4
ftrErrInternalErr	=	ftrErrorClass|5
			| System\FeaturePrv.h
FtrFeatureType.num = 0
FtrFeatureType.value = 2
FtrCreatorType.creator = 0
FtrCreatorType.numEntries = 4
FtrCreatorType.feature.FtrFeatureTy = 6
FtrTableType.numEntries = 0
FtrTableType.creator.FtrCreatorTy = 2
FtrGlobalsType.romTableH = 0
FtrGlobalsType.ramTableH = 4
FtrCacheType.romTableH = 0
FtrCacheType.ramTableH = 4
FtrCacheType.romTableP = 8
FtrCacheType.ramTableP = 12
			| System\FileStream.h
fileErrMemError	=	fileErrorClass|1
fileErrInvalidParam	=	fileErrorClass|2
fileErrCorruptFile	=	fileErrorClass|3
fileErrNotFound	=	fileErrorClass|4
fileErrTypeCreatorMismatch	=	fileErrorClass|5
fileErrReplaceError	=	fileErrorClass|6
fileErrCreateError	=	fileErrorClass|7
fileErrOpenError	=	fileErrorClass|8
fileErrInUse	=	fileErrorClass|9
fileErrReadOnly	=	fileErrorClass|10
fileErrInvalidDescriptor	=	fileErrorClass|11
fileErrCloseError	=	fileErrorClass|12
fileErrOutOfBounds	=	fileErrorClass|13
fileErrPermissionDenied	=	fileErrorClass|14
fileErrIOError	=	fileErrorClass|15
fileErrEOF	=	fileErrorClass|16
fileErrNotStream	=	fileErrorClass|17
fileNullHandle	=	0
fileModeReadOnly	=	0x80000000
fileModeReadWrite	=	0x40000000
fileModeUpdate	=	0x20000000
fileModeAppend	=	0x10000000
fileModeLeaveOpen	=	0x08000000
fileModeExclusive	=	0x04000000
fileModeAnyTypeCreator	=	0x02000000
fileModeTemporary	=	0x01000000
fileModeDontOverwrite	=	0x00800000
fileModeAllFlags	=	fileModeReadOnly|fileModeReadWrite|fileModeUpdate|fileModeAppend|fileModeLeaveOpen|fileModeExclusive|fileModeAnyTypeCreator|fileModeTemporary|fileModeDontOverwrite
			| FileOriginEnum
fileOriginBeginning	=	1
fileOriginCurrent	=	2
fileOriginEnd	=	3
			| FileOpEnum
fileOpNone	=	0
fileOpDestructiveReadMode	=	1
fileOpGetEOFStatus	=	2
fileOpGetLastError	=	3
fileOpClearError	=	4
fileOpGetIOErrorStatus	=	5
fileOpGetCreatedStatus	=	6
fileOpGetOpenDbRef	=	7
fileOpFlush	=	8
fileOpLAST	=	9
			| System\FileStreamPrv.h
fileDescriptorSignature	=	0x5354524d
fileStateOpenComplete	=	(0x8000)
fileStateWriteAccess	=	(0x4000)
fileStateDestructiveRead	=	(0x2000)
fileStateAppend	=	(0x1000)
fileStateCreated	=	(0x0800)
fileStateCompressed	=	(0x0400)
fileStateIOError	=	(0x0001)
fileStateEOF	=	(0x0002)
fileAllStates	=	fileStateOpenComplete|fileStateWriteAccess|fileStateDestructiveRead|fileStateAppend|fileStateCreated|fileStateCompressed|fileStateIOError|fileStateEOF
FileCachedInfoType.blockH = 0
FileCachedInfoType.blockIndex = 4
FileCachedInfoType.forWrite = 8
FileCachedInfoType.bReserved = 8
FileDescriptorType.sig = 0
FileDescriptorType.openMode = 4
FileDescriptorType.state = 8
FileDescriptorType.dbR = 10
FileDescriptorType.lastError = 14
FileDescriptorType.fileSize = 16
FileDescriptorType.numBlocks = 20
FileDescriptorType.curOffset = 24
FileDescriptorType.cached.FileCachedInfoTy = 28
FileDescriptorType.dwReserved1 = 28
FileDescriptorType.dwReserved2 = 32
fileBlockDataSize	=	1024*4
fileDataBlockSignature	=	0x44424c4b
fileDataBlockCategory	=	dmUnfiledCategory
FileBlockHeaderType.sig = 0
FileBlockHeaderType.dataSize = 4
FileDataBlockType.hdr.FileBlockHeaderTy = 0
FileDataBlockType.data.40 = 0
			| System\FloatMgr.h
fMaxLong	=	(0x7FFFFFFF)
fMinLong	=	(0x80000000)
FloatTypeFloatType.man = 0
FloatTypeFloatType.exp = 4
FloatTypeFloatType.sign = 6
FloatTypeFloatType.pad = 6
kExpInf	=	16000
fplErrOutOfRange	=	fplErrorClass|1
			| System\Globals.h
sysUIRsvGlobalsSize	=	0x000000a0
FixedGlobalsType.memCardSlots = 0
FixedGlobalsType.dbgWasEntered = 0
FixedGlobalsType.memCardInfoP = 0
FixedGlobalsType.memSemaphoreID = 4
FixedGlobalsType.memDebugMode = 8
FixedGlobalsType.dmOpenList = 10
FixedGlobalsType.dbgInDebugger = 14
FixedGlobalsType.dbgTracing = 14
FixedGlobalsType.dbgGlobalsP = 14
FixedGlobalsType.dbgSerGlobalsP = 18
FixedGlobalsType.sysAppInfoP = 22
FixedGlobalsType.sysKernelDataP = 26
FixedGlobalsType.sysDispatchTableP = 30
FixedGlobalsType.sysOwnerIDsInUse = 34
FixedGlobalsType.sysAMXAppInfoP = 38
FixedGlobalsType.sysClockFreq = 42
FixedGlobalsType.sysHardKeyCreators = 46
FixedGlobalsType.sysBatteryCheckTimer = 50
FixedGlobalsType.sysBatteryMinThreshold = 52
FixedGlobalsType.hwrBatteryLevel = 52
FixedGlobalsType.sysNextBatteryAlertTimer = 52
FixedGlobalsType.sysBatteryWarnThreshold = 54
FixedGlobalsType.sysDispatchTableRev = 54
FixedGlobalsType.sysDispatchTableSize = 54
FixedGlobalsType.sysLibTableP = 56
FixedGlobalsType.sysLibTableEntries = 60
FixedGlobalsType.sysConsoleStackChunkP = 62
FixedGlobalsType.sysUIShellAppInfoP = 66
FixedGlobalsType.sysTimerID = 70
FixedGlobalsType.sysAutoOffEvtTicks = 74
FixedGlobalsType.sysAutoOffSeconds = 78
FixedGlobalsType.sysRandomSeed = 80
FixedGlobalsType.slkGlobalsP = 84
FixedGlobalsType.serGlobalsP = 88
FixedGlobalsType.scrGlobalsP = 92
FixedGlobalsType.fplGlobalsP = 96
FixedGlobalsType.penGlobalsP = 100
FixedGlobalsType.sysEvtMgrGlobalsP = 104
FixedGlobalsType.sndGlobalsP = 108
FixedGlobalsType.timGlobalsP = 112
FixedGlobalsType.almGlobalsP = 116
FixedGlobalsType.ftrGlobalsP = 120
FixedGlobalsType.grfGlobalsP = 124
FixedGlobalsType.keyGlobalsP = 128
FixedGlobalsType.uiGlobals.1 = 132
FixedGlobalsType.uiExtensionsP = 132
FixedGlobalsType.unusedPtr = 136
FixedGlobalsType.nextUIAppDBID = 140
FixedGlobalsType.nextUIAppCmd = 144
FixedGlobalsType.nextUIAppCmdPBP = 146
FixedGlobalsType.nextUIAppCardNo = 150
FixedGlobalsType.hwrDataWELevel = 150
FixedGlobalsType.hwrWakeUp = 150
FixedGlobalsType.hwrCPUDutyCycle = 152
FixedGlobalsType.hwrPenDown = 152
FixedGlobalsType.hwrCurTicks = 152
FixedGlobalsType.hwrTotalRAMSize = 156
FixedGlobalsType.hwrDozeSubTicks = 160
FixedGlobalsType.sndOffTicks = 164
FixedGlobalsType.sysResetFlags = 168
FixedGlobalsType.sysBatteryKind = 168
FixedGlobalsType.memMinDynHeapFree = 168
FixedGlobalsType.sysPrefFlags = 172
FixedGlobalsType.sysGlobalsP = 174
FixedGlobalsType.sysMiscFlags = 178
FixedGlobalsType.sysLibNet = 180
FixedGlobalsType.netPktFreeQ = 182
FixedGlobalsType.sysEvGroupID = 186
FixedGlobalsType.irq3GlobalsP = 190
FixedGlobalsType.sysLastBatteryWarning = 194
FixedGlobalsType.sysLowMemChecksum = 198
FixedGlobalsType.hwrHardwareRev = 202
FixedGlobalsType.Handle = 204
FixedGlobalsType.dmProtectListH = 208
FixedGlobalsType.hwrMiscFlags = 212
FixedGlobalsType.sysProfileRefcon = 214
FixedGlobalsType.sysProfileProcP = 218
FixedGlobalsType.flpSoftFPSCR = 222
FixedGlobalsType.irLibGlobalsP = 226
FixedGlobalsType.exgActiveLib = 230
FixedGlobalsType.uiBusyCount = 232
FixedGlobalsType.irq1GlobalsP = 234
FixedGlobalsType.irq2GlobalsP = 238
FixedGlobalsType.irq6GlobalsP = 242
LowMemHdrType.vectors.M68KExcTableTy = 0
LowMemHdrType.globals.FixedGlobalsTy = 0
PilotGlobalsP	=	0
			| System\Graffiti.h
grfNoShortCut	=	0xffff
GrfMatchType.glyphID = 0
GrfMatchType.unCertainty = 0
grfMaxMatches	=	4
GrfMatchInfoType.numMatches = 0
GrfMatchInfoType.match = 2
grfNameLength	=	8
grfVirtualSequence	=	0x01
grfShiftSequence	=	0x02
grfSpecialSequence	=	0x03
grfExpansionSequence	=	'@'
expandDateChar	=	'D'
expandTimeChar	=	'T'
expandStampChar	=	'S'
shortcutBinaryDataFlag	=	0x01
grfTempShiftPunctuation	=	1
grfTempShiftExtended	=	2
grfTempShiftUpper	=	3
grfTempShiftLower	=	4
grfErrBadParam	=	grfErrorClass|1
grfErrPointBufferFull	=	grfErrorClass|2
grfErrNoGlyphTable	=	grfErrorClass|3
grfErrNoDictionary	=	grfErrorClass|4
grfErrNoMapping	=	grfErrorClass|5
grfErrMacroNotFound	=	grfErrorClass|6
grfErrDepthTooDeep	=	grfErrorClass|7
grfErrMacroPtrTooSmall	=	grfErrorClass|8
grfErrNoMacros	=	grfErrorClass|9
grfErrMacroIncomplete	=	grfErrorClass|129
grfErrBranchNotFound	=	grfErrorClass|130
			| System\GraffitiPrv.h
grfSpecialToggleSplitMode	=	0x01
grfSpecialNoAutoOff	=	0x02
grfSpecialShowUserInfo	=	0x03
grfSpecialDeleteUserInfo	=	0x04
grfSpecialSystemBuildDate	=	0x05
grfSpecialBatteryKind	=	0x06
grfMaxKeys	=	100
grfMacrosResT	=	0x6d616372
grfMacrosResID	=	10000
grfMacrosMinSize	=	10
grfMacrosDBVersion	=	0
grfWarningOffset	=	128
grfMaxMacroName	=	32
			|struct GrfGlobalsType
			|	p3Data.TP3Data
			|	state.TP3DictState
			|	uncertain.w
			|	glyphFlags.w
			|	shiftState.w
			|	macroNameLen.w
			|	macroName.grfMaxMacroName
			|	lastChar.b
			|	pad.b
			|	globalsSize.l
			|	splitMode.w
			|	restoreCaps.w
			|	inMacro.w
			|	wasAutoShifted.w
			|	upShiftGlyphID.b
			|	pad2.b
			|	Handle.l
			|	globalsH.l
			|	Handle.l
			|	templateH.l
			|	Handle.l
			|	dictH.l
			|	Handle.l
			|	macrosH.l
			|	macrosDbP.l
			|endstruct
			| System\GraffitiReference.h
			| ReferenceType
referenceAlpha	=	0
referencePunc1	=	1
referencePunc2	=	2
referencePunc3	=	3
referenceExtended	=	4
referenceAccent	=	5
referenceDefault	=	0xff
referenceFirst	=	referenceAlpha
referenceLast	=	referenceAccent
			| System\ImcUtils.h
EOF	=	0xffff
parameterDelimeterChr	=	'	|'
valueDelimeterChr	=	':'
groupDelimeterChr	=	'.'
paramaterNameDelimiterChr	=	'='
endOfLineChr	=	0x0D
imcFilenameLength	=	32
imcUnlimitedChars	=	0xFFFE
			| System\irlib.h
			|irLibName	equ	"IrDA Library"
			|irFtrCreator	equ	sysFileCIrLib
irFtrNumVersion	=	0
irOpenOptBackground	=	0x80000000
irOpenOptSpeed115200	=	0x0000003F
irOpenOptSpeed57600	=	0x0000001F
irOpenOptSpeed9600	=	0x00000003
			|irGetScanningMode	equ	exgibCtlSpecificOp
			|irSetScanningMode	equ	exgibCtlSpecificOp
			|irGetStatistics	equ	exgibCtlSpecificOp
			|irSetSerialMode	equ	exgibCtlSpecificOp
			|irSetBaudMask	equ	exgibCtlSpecificOp
			|irSetSupported	equ	exgibCtlSpecificOp
IrStatsType.recLineErrors = 0
IrStatsType.crcErrors = 2
			|???	} IrLibTrapNumberEnum;
			|???	irLibTrapBind = exgLibTrapLast
			|???	irLibTrapUnBind,
			|???	irLibTrapDiscoverReq,
			|???	irLibTrapConnectIrLap,
			|???	irLibTrapDisconnectIrLap,
			|???	irLibTrapConnectReq,
			|???	irLibTrapConnectRsp,
			|???	irLibTrapDataReq,
			|???	irLibTrapLocalBusy,
			|???	irLibTrapMaxTxSize,
			|???	irLibTrapMaxRxSize,
			|???	irLibTrapSetDeviceInfo,
			|???	irLibTrapIsNoProgress,
			|???	irLibTrapIsRemoteBusy,
			|???	irLibTrapIsMediaBusy,
			|???	irLibTrapIsIrLapConnected,
			|???	irLibTrapTestReq,
			|???	irLibTrapIAS_Add,
			|???	irLibTrapIAS_Query,
			|???	irLibTrapIAS_SetDeviceName,
			|???	irLibTrapIAS_Next,
			|???	irLibTrapIrOpen,
			|???	irLibTrapHandleEvent,
			|???	irLibTrapWaitForEvent,
			|???	irLibTrapLast
IR_MAX_CON_PACKET	=	60
IR_MAX_TTP_CON_PACKET	=	52
IR_MAX_TEST_PACKET	=	376
IR_MAX_DEVICE_INFO	=	23
IR_DEVICE_LIST_SIZE	=	6
IR_MAX_XID_LEN	=	23
IR_MAX_LSAP	=	0x6f
IR_HINT_PNP	=	0x01
IR_HINT_PDA	=	0x02
IR_HINT_COMPUTER	=	0x04
IR_HINT_PRINTER	=	0x08
IR_HINT_MODEM	=	0x10
IR_HINT_FAX	=	0x20
IR_HINT_LAN	=	0x40
IR_HINT_EXT	=	0x80
IR_HINT_TELEPHONY	=	0x01
IR_HINT_FILE	=	0x02
IR_HINT_IRCOMM	=	0x04
IR_HINT_MESSAGE	=	0x08
IR_HINT_HTTP	=	0x10
IR_HINT_OBEX	=	0x20
			|???typedef Byte IrStatus;
			|???typedef Byte IrCharSet;
IR_CHAR_ASCII	=	0
IR_CHAR_ISO_8859_1	=	1
IR_CHAR_ISO_8859_2	=	2
IR_CHAR_ISO_8859_3	=	3
IR_CHAR_ISO_8859_4	=	4
IR_CHAR_ISO_8859_5	=	5
IR_CHAR_ISO_8859_6	=	6
IR_CHAR_ISO_8859_7	=	7
IR_CHAR_ISO_8859_8	=	8
IR_CHAR_ISO_8859_9	=	9
IR_CHAR_UNICODE	=	0xff
			|???typedef Byte IrEvent;
LEVENT_LM_CON_IND	=	0
LEVENT_LM_DISCON_IND	=	1
LEVENT_DATA_IND	=	2
LEVENT_PACKET_HANDLED	=	3
LEVENT_LAP_CON_IND	=	4
LEVENT_LAP_DISCON_IND	=	5
LEVENT_DISCOVERY_CNF	=	6
LEVENT_LAP_CON_CNF	=	7
LEVENT_LM_CON_CNF	=	8
LEVENT_STATUS_IND	=	9
LEVENT_TEST_IND	=	10
LEVENT_TEST_CNF	=	11
LCON_FLAGS_TTP	=	0x02
IR_MAX_QUERY_LEN	=	61
IR_MAX_IAS_NAME	=	60
IR_MAX_ATTRIBUTES	=	255
IR_MAX_IAS_ATTR_SIZE	=	56
IAS_ATTRIB_MISSING	=	0
IAS_ATTRIB_INTEGER	=	1
IAS_ATTRIB_OCTET_STRING	=	2
IAS_ATTRIB_USER_STRING	=	3
IAS_ATTRIB_UNDEFINED	=	0xff
IAS_GET_VALUE_BY_CLASS	=	4
			|struct IrPacket
			|	node.ListEntry
			|	buff.l
			|	len.w
			|	origin.l
			|	headerLen.b
			|	pad.b
			|	header.14
			|endstruct
			|???typedef  union {
			|???    Byte  u8[4];
			|???    Word  u16[2];
			|???    DWord u32;
			|???} IrDeviceAddr;
IrDeviceInfo.hDevice = 0
IrDeviceInfo.len = 4
IrDeviceInfo.xid. = 4
			|pstruct IrDeviceList
			|	nItems.b
			|	pad.b
			| IrDeviceInfo  dev[IR_DEVICE_LIST_SIZE]; /* Fixed size in IrDA Lite */
			|endstruct IrDeviceList
IrCallBackParms.event = 0
IrCallBackParms.pad = 0
IrCallBackParms.rxBuff = 0
IrCallBackParms.rxLen = 4
IrCallBackParms.packet = 6
IrCallBackParms.deviceList = 10
IrCallBackParms.status = 14
			|struct _hconnect
			|	lLsap.b
			|	rLsap.b
			|	flags.b
			|	pad.b
			|	callBack.l
			|	packet.IrPacket
			|	packets.ListEntry
			|	sendCredit.w
			|	availCredit.b
			|	dataOff.b
			|endstruct
_IrIasAttribute.name = 0
_IrIasAttribute.len = 4
_IrIasAttribute.pad = 4
_IrIasAttribute.value = 4
_IrIasAttribute.valLen = 8
_IrIasObject.name = 0
_IrIasObject.len = 4
_IrIasObject.nAttribs = 4
_IrIasObject.attribs = 4
_IrIasQuery.queryLen = 0
_IrIasQuery.pad = 0
_IrIasQuery.queryBuf = 0
_IrIasQuery.resultBufSize = 4
_IrIasQuery.resultLen = 6
_IrIasQuery.listLen = 8
_IrIasQuery.offset = 10
_IrIasQuery.retCode = 12
_IrIasQuery.overFlow = 12
_IrIasQuery.result = 12
			| System\KeyMgr.h
keyBitPower	=	0x01
keyBitPageUp	=	0x02
keyBitPageDown	=	0x04
keyBitHard1	=	0x08
keyBitHard2	=	0x10
keyBitHard3	=	0x20
keyBitHard4	=	0x40
keyBitCradle	=	0x80
keyBitsAll	=	0xFFFFFFFF
slowestKeyDelayRate	=	0xff
slowestKeyPeriodRate	=	0xff
			| System\KeyPrv.h
			|keyMinUpTicks	equ	sysTicksPerSecond/20
			|keyMinBacklightTicks	equ	sysTicksPerSecond
keyBitMask	=	0x007F
KeyGlobalsType.lastKeyTicks = 0
KeyGlobalsType.keyState = 4
KeyGlobalsType.keyStateMask = 4
KeyGlobalsType.keyUpCount = 4
KeyGlobalsType.initDelay = 4
KeyGlobalsType.period = 4
KeyGlobalsType.turnOnTicks = 4
KeyGlobalsType.doubleTapTicks = 8
KeyGlobalsType.doubleTapDelay = 12
KeyGlobalsType.doubleTapState = 14
KeyGlobalsType.Belongs = 14
KeyGlobalsType.queueAhead = 18
			| System\Launcher.h
LauncherType.form = 0
LauncherType.numItems = 4
LauncherType.columns = 6
LauncherType.rows = 8
LauncherType.topItem = 10
LauncherType.selection = 12
LauncherType.appInfoH = 12
LauncherType.timeFormat = 16
LauncherType.timeString = 18
LauncherType.pad = 18
LauncherType.savedForm = 18
			| System\MemoryMgr.h
			| LocalIDKind
memIDPtr	=	0
memIDHandle	=	1
memNewChunkFlagPreLock	=	0x0100
memNewChunkFlagNonMovable	=	0x0200
memNewChunkFlagAtStart	=	0x0400
memNewChunkFlagAtEnd	=	0x0800
memDebugModeCheckOnChange	=	0x0001
memDebugModeCheckOnAll	=	0x0002
memDebugModeScrambleOnChange	=	0x0004
memDebugModeScrambleOnAll	=	0x0008
memDebugModeFillFree	=	0x0010
memDebugModeAllHeaps	=	0x0020
memDebugModeRecordMinDynHeapFree	=	0x0040
memErrChunkLocked	=	memErrorClass|1
memErrNotEnoughSpace	=	memErrorClass|2
memErrChunkNotLocked	=	memErrorClass|4
memErrCardNotPresent	=	memErrorClass|5
memErrNoCardHeader	=	memErrorClass|6
memErrInvalidStoreHeader	=	memErrorClass|7
memErrRAMOnlyCard	=	memErrorClass|8
memErrWriteProtect	=	memErrorClass|9
memErrNoRAMOnCard	=	memErrorClass|10
memErrNoStore	=	memErrorClass|11
			| System\MidiPrv.h
midiSmfHeaderChunkType	=	0x4d546864
midiSmfTrackChunkType	=	0x4d54726b
midiSmfFmt0	=	0
midiSmfFmt1	=	1
midiSmfFmt2	=	2
midiSmfFmtUnknown	=	0xFFFF
midiSmfMaxValidFmt	=	midiSmfFmt2
midiSmfNegSMPTEFmt24	=	-24
midiSmfNegSMPTEFmt25	=	-25
midiSmfNegSMPTEFmt30Drop	=	-29
midiSmfNegSMPTEFmt30NonDrop	=	-30
midiMsgStatusNone	=	0
midiMaxChanMsgStatus	=	0xEF
midiMsgBaseNoteOff	=	0x080
midiMsgBaseNoteOn	=	0x090
midiMsgBasePolyPress	=	0x0A0
midiMsgBaseCtlChange	=	0x0B0
midiMsgBaseProgChange	=	0x0C0
midiMsgBaseChanPress	=	0x0D0
midiMsgBasePitchBend	=	0x0E0
midiSmfEvtStatusMeta	=	0xFF
midiSmfEvtStatusSysExF0	=	0xF0
midiSmfEvtStatusSysExF7	=	0xF7
midiSmfMetaEvtTypeEOT	=	0x2F
midiSmfMetaEvtTypeTempo	=	0x51
midiStatusBit	=	0x80
midiChanNumMask	=	0x0F
midiChanMsgMask	=	0xF0
midiSmfSMPTEDivBit	=	0x8000
midiSmfSMPTEDivTicksMask	=	0x00FF
midiMinChan	=	0
midiMaxChan	=	15
midiMinKey	=	0
midiMaxKey	=	127
midiMinVel	=	0
midiMaxVel	=	127
midiSmfMinHdrChunkDataSize	=	6
midiSmfMinTrkChunkDataSize	=	4
midiDefTempo	=	500000
midiDefVel	=	64
midiSmfHdrFmtBytes	=	2
midiSmfHdrTrkBytes	=	2
midiSmfHdrDivBytes	=	2
midiSmfChunkTypeBytes	=	4
midiSmfChunkLengthBytes	=	4
midiSmfTempoBytes	=	3
MidiSmfHdrInfoType.wFmt = 0
MidiSmfHdrInfoType.wNumTracks = 2
MidiSmfHdrInfoType.wDivRaw = 4
MidiSmfHdrInfoType.bUsingSMPTE = 6
MidiSmfHdrInfoType.pad = 6
MidiSmfHdrInfoType.wTicksPerQN = 6
MidiSmfHdrInfoType.dwTicksPerSec = 8
MidiStateType.hdr.MidiSmfHdrInfoTy = 0
MidiStateType.streamP = 0
MidiStateType.chunkEndP = 4
MidiStateType.dwChunkType = 8
MidiStateType.dwChunkSize = 12
MidiStateType.bMsgStatus = 16
MidiStateType.pad = 16
MidiStateType.dwTempo = 16
MidiStateType.bFirstChan = 20
MidiStateType.bLastChan = 20
			|???typedef enum MidiSmfEvtClassEnum {
			|???	eMidiSmfEvtClassUnknown = 0,
			|???	eMidiSmfEvtClassChannel,
			|???	eMidiSmfEvtClassSysEx,
			|???	eMidiSmfEvtClassMeta
			|???	} MidiSmfEvtClassEnum;
			|???typedef enum MidiSmfEvtEnum {
			|???	eMidiSmfEvtUnknown		= 0,
			|???	eMidiSmfEvtNoteOff		= 0x080,
			|???	eMidiSmfEvtNoteOn			= 0x090,
			|???	eMidiSmfEvtPolyPress		= 0x0A0,
			|???	eMidiSmfEvtCtlChange		= 0x0B0,
			|???	eMidiSmfEvtProgChange	= 0x0C0,
			|???	eMidiSmfEvtChanPress		= 0x0D0,
			|???	eMidiSmfEvtPitchBend		= 0x0E0,
			|???	eMidiSmfEvtSysEx1			= 0x0F0,
			|???	eMidiSmfEvtSysEx2			= 0x0F7,
			|???	eMidiSmfMetaEvtEOT		= 0xFF2F,
			|???	eMidiSmfMetaEvtTempo		= 0xFF51,
			|???	eMidiSmfMetaEvtOther		= 0xFF80
			|???	} MidiSmfEvtEnum;
MidiEventType.id = 0
MidiEventType.evtClass = 2
MidiEventType.dwDeltaTicks = 4
MidiEventType.bChan = 8
MidiEventType.evtData = 8
setTempo.dwTempo = 0
note.bKey = 0
note.bVel = 0
			| System\ModemMgr.h
mdmMaxStringSize	=	40
mdmCmdBufSize	=	81
mdmRespBufSize	=	81
mdmCmdSize	=	8
mdmDefCmdTimeOut	=	500000
mdmDefDTWaitSec	=	4
mdmDefDCDWaitSec	=	70
mdmDefSpeakerVolume	=	1
			|???enum {
			|???	mdmVolumeOff = 0,
			|???	mdmVolumeLow = 1,
			|???	mdmVolumeMed = 2,
			|???	mdmVolumeHigh = 3
			|???	};
			|???typedef enum {
			|???	mdmStageInvalid = 0,
			|???	mdmStageReserved = 1,
			|???	mdmStageFindingModem,
			|???	mdmStageInitializing,
			|???	mdmStageDialing,
			|???	mdmStageWaitingForCarrier,
			|???	mdmStageHangingUp
			|???	} MdmStageEnum;
MdmInfoType.serRefNum = 0
MdmInfoType.initialBaud = 2
MdmInfoType.cmdTimeOut = 6
MdmInfoType.dtWaitSec = 10
MdmInfoType.dcdWaitSec = 12
MdmInfoType.volume = 14
MdmInfoType.pulse = 16
MdmInfoType.hwHShake = 16
MdmInfoType.autoBaud = 16
MdmInfoType.pad = 16
MdmInfoType.canProcP = 16
MdmInfoType.userRef = 20
MdmInfoType.cmdBuf. = 24
MdmInfoType.respBuf. = 24
MdmInfoType.connectBaud = 24
MdmInfoType.curStage = 28
MdmInfoType.pad2 = 28
mdmErrNoTone	=	mdmErrorClass|1
mdmErrNoDCD	=	mdmErrorClass|2
mdmErrBusy	=	mdmErrorClass|3
mdmErrUserCan	=	mdmErrorClass|4
mdmErrCmdError	=	mdmErrorClass|5
mdmErrNoModem	=	mdmErrorClass|6
mdmErrMemory	=	mdmErrorClass|7
mdmErrPrefs	=	mdmErrorClass|8
mdmErrDial	=	mdmErrorClass|9
			| System\ModemPrv.h
mdmDefaultResponseWait	=	300000
			|???typedef enum  {
			|???	mdmCmdCSI,
			|???	mdmCmdEOC,
			|???	mdmCmdQuiet,
			|???	mdmCmdDialTone,
			|???	mdmCmdDialPulse,
			|???	mdmCmdEchoOff,
			|???	mdmCmdVerbose,
			|???	mdmCmdDTWait,
			|???	mdmCmdDCDWait,
			|???	mdmCmdBasicXCmd,
			|???	mdmCmdAdvXCmd,
			|???	mdmCmdSpkrOnTillConnect,
			|???	mdmCmdSpkrOff,
			|???	mdmCmdVolume,
			|???	mdmCmdHUP,
			|???	mdmCmdFirmDTRDCD,
			|???	mdmCmdEscape,
			|???	mdmCmdReset,
			|???	mdmCmdFactory,
			|???	mdmCmdRetToCmdMode
			|???	} MdmCmdEnum;
			|???typedef enum MdmRespIDType {
			|???	mdmRespUnknown = 0,
			|???	mdmRespOK,
			|???	mdmRespConnect,
			|???	mdmRespNoCarrier,
			|???	mdmRespError,
			|???	mdmRespNoDialTone,
			|???	mdmRespBusy,
			|???	mdmRespRing,
			|???
			|???	mdmRespReserved = -1
			|???	} MdmRespIDType;
			|???enum {
			|???	mdmHandshakeStd		= 0,
			|???	mdmHandshakeOff		= 1,
			|???	mdmHandshakeOn			= 2
			|???	};
mdmPrefVersionNum	=	2
			|struct MdmPrefType
			|	version.w
			|	baud.l
			|	volume.b
			|	pulse.b
			|	hShk.b
			|	autoBaud.b
			|	resetString[(mdmCmdSize*2)+1].b
			|	initString[mdmCmdBufSize].b
			|endstruct MdmPrefTypeMdmPrefType
mdmDefaultDialMode	=	false
mdmDefaultBaud	=	19200
			|mdmDefaultVolume	equ	mdmVolumeow
mdmDefaultPulse	=	false
			|mdmDefaultHShk		equ	mdmHandshakeStd
mdmDefaultAutoBaud	=	false
			|mdmDefaultResetString	equ	""
			|mdmDefaultInitString	equ	"&F&B1X4"
			| System\NewFloatMgr.h
flpVersion	=	0x02008000
flpToNearest	=	0
flpTowardZero	=	1
flpUpward	=	3
flpDownward	=	2
flpModeMask	=	0x00000030
flpModeShift	=	4
flpInvalid	=	0x00008000
flpOverflow	=	0x00004000
flpUnderflow	=	0x00002000
flpDivByZero	=	0x00001000
flpInexact	=	0x00000800
flpEqual	=	0
flpLess	=	1
flpGreater	=	2
flpUnordered	=	3
_sfpe_64_bits.high = 0
_sfpe_64_bits.low = 4
FlpDoubleBits.sign = 0
FlpDoubleBits.exp = 4
FlpDoubleBits.manH = 8
FlpDoubleBits.manL = 12
			|???typedef union {
			|???        double				d;
			|???        FlpDouble			fd;
			|???        DWord				ul[2];
			|???        FlpDoubleBits	fdb;
			|???} FlpCompDouble;
			|???typedef union {
			|???        float				f;
			|???        FlpFloat			ff;
			|???        DWord				ul;
			|???} FlpCompFloat;
flpErrOutOfRange	=	flpErrorClass|1
m68kMoveQd2Instr	=	0x7400
			|???typedef enum {
			|???	sysFloatBase10Info = 0,
			|???	sysFloatFToA,
			|???	sysFloatAToF,
			|???	sysFloatCorrectedAdd,
			|???	sysFloatCorrectedSub,
			|???	sysFloatVersion,
			|???	flpMaxFloatSelector = sysFloatVersion
			|???} sysFloatSelector;
			|???typedef enum {
			|???	sysFloatEm_fp_round = 0,
			|???	sysFloatEm_fp_get_fpscr,
			|???	sysFloatEm_fp_set_fpscr,
			|???	sysFloatEm_f_utof,
			|???	sysFloatEm_f_itof,
			|???	sysFloatEm_f_ulltof,
			|???	sysFloatEm_f_lltof,
			|???	sysFloatEm_d_utod,
			|???	sysFloatEm_d_itod,
			|???	sysFloatEm_d_ulltod,
			|???	sysFloatEm_d_lltod,
			|???	sysFloatEm_f_ftod,
			|???	sysFloatEm_d_dtof,
			|???	sysFloatEm_f_ftoq,
			|???	sysFloatEm_f_qtof,
			|???	sysFloatEm_d_dtoq,
			|???	sysFloatEm_d_qtod,
			|???	sysFloatEm_f_ftou,
			|???	sysFloatEm_f_ftoi,
			|???	sysFloatEm_f_ftoull,
			|???	sysFloatEm_f_ftoll,
			|???	sysFloatEm_d_dtou,
			|???	sysFloatEm_d_dtoi,
			|???	sysFloatEm_d_dtoull,
			|???	sysFloatEm_d_dtoll,
			|???	sysFloatEm_f_cmp,
			|???	sysFloatEm_f_cmpe,
			|???	sysFloatEm_f_feq,
			|???	sysFloatEm_f_fne,
			|???	sysFloatEm_f_flt,
			|???	sysFloatEm_f_fle,
			|???	sysFloatEm_f_fgt,
			|???	sysFloatEm_f_fge,
			|???	sysFloatEm_f_fun,
			|???	sysFloatEm_f_for,
			|???	sysFloatEm_d_cmp,
			|???	sysFloatEm_d_cmpe,
			|???	sysFloatEm_d_feq,
			|???	sysFloatEm_d_fne,
			|???	sysFloatEm_d_flt,
			|???	sysFloatEm_d_fle,
			|???	sysFloatEm_d_fgt,
			|???	sysFloatEm_d_fge,
			|???	sysFloatEm_d_fun,
			|???	sysFloatEm_d_for,
			|???	sysFloatEm_f_neg,
			|???	sysFloatEm_f_add,
			|???	sysFloatEm_f_mul,
			|???	sysFloatEm_f_sub,
			|???	sysFloatEm_f_div,
			|???	sysFloatEm_d_neg,
			|???	sysFloatEm_d_add,
			|???	sysFloatEm_d_mul,
			|???	sysFloatEm_d_sub,
			|???	sysFloatEm_d_div
			|???} sysFloatEmSelector;
			| System\Password.h
pwdLength	=	32
pwdEncryptionKeyLength	=	64
			| System\PenMgr.h
penErrBadParam	=	penErrorClass|1
			| System\PenPrv.h
penCalibrateTop	=	10
penCalibrateLeft	=	10
penCalibrateBottom	=	hwrDisplayHeight-10
penCalibrateRight	=	hwrDisplayWidth-10
penInitDelay	=	0x180
penBBDelay	=	105
penInitMaxDDZ	=	12
penInitMaxSlop	=	2
penInitMaxRetries	=	3
penInitMaxEndBlip	=	5
penNumSamples	=	5
penHotSample	=	2
penMinUpSamples	=	3
penMinDownSamples	=	1
penDownButInvalid	=	0x7FFF
PenGlobalsType.calibrated = 0
PenGlobalsType.filler = 0
PenGlobalsType.xOffset = 0
PenGlobalsType.yOffset = 2
PenGlobalsType.xScale = 4
PenGlobalsType.yScale = 6
PenGlobalsType.sample. = 8
PenGlobalsType.delay = 8
PenGlobalsType.maxDDZ = 10
PenGlobalsType.maxRetries = 12
PenGlobalsType.maxSlop = 14
PenGlobalsType.maxEndBlip = 16
PenGlobalsType.penDownCount = 18
PenGlobalsType.penDownCountInit = 20
			| System\PilotStdio.h
SEEK_SET	=	fileOriginBeginning
SEEK_CUR	=	fileOriginCurrent
SEEK_END	=	fileOriginEnd
			| System\SysConfigPrv.h
mem32K	=	0x008000
mem64K	=	0x010000
mem96K	=	0x018000
mem128K	=	0x020000
mem256K	=	0x040000
mem512K	=	0x080000
mem1MB	=	0x100000
mem2MB	=	0x200000
			| System\SysEvtMgr.h
evtErrParamErr	=	evtErrorClass|1
evtErrQueueFull	=	evtErrorClass|2
evtErrQueueEmpty	=	evtErrorClass|3
			| UI\Rect.h
AbsRectType.left = 0
AbsRectType.top = 2
AbsRectType.right = 4
AbsRectType.bottom = 6
PointType.x = 0
PointType.y = 2
RectangleType.topLeft.PointTy = 0
RectangleType.extent.PointTy = 0
			| System\SysEvtPrv.h
PenQueueType.start = 0
PenQueueType.end = 2
PenQueueType.size = 4
PenQueueType.strokeCount = 6
PenQueueType.returnedPenDown = 8
PenQueueType.pad = 8
PenQueueType.addLast.PointTy = 8
PenQueueType.addStrokeStart = 8
PenQueueType.strokesRemoved = 10
PenQueueType.strokesAdded = 12
PenQueueType.rmvStrokeStage = 14
PenQueueType.rmvLast.PointTy = 16
PenQueueType.rmvStartPt.PointTy = 16
PenQueueType.data = 16
KeyQueueType.start = 0
KeyQueueType.end = 2
KeyQueueType.size = 4
KeyQueueType.data = 6
PenBtnInfoType.boundsR.RectangleTy = 0
PenBtnInfoType.asciiCode = 0
PenBtnInfoType.keyCode = 2
PenBtnInfoType.modifiers = 4
evtKeyStringEscape	=	0x01
evtDefaultPenQSize	=	0x100
evtDefaultKeyQSize	=	0x40
grmGremlinsOn	=	0x01
grmEventTraceOn	=	0x02
grmGremlinsIdle	=	0x04
SysEvtMgrGlobalsType.sendNullEvent = 0
SysEvtMgrGlobalsType.enableGraffiti = 0
SysEvtMgrGlobalsType.enableSoftKeys = 0
SysEvtMgrGlobalsType.removeTopStroke = 0
SysEvtMgrGlobalsType.penQP = 0
SysEvtMgrGlobalsType.penQStrokesRemoved = 4
SysEvtMgrGlobalsType.keyQP = 6
SysEvtMgrGlobalsType.writingR.RectangleTy = 10
SysEvtMgrGlobalsType.appAreaBottom = 10
SysEvtMgrGlobalsType.penX = 12
SysEvtMgrGlobalsType.penY = 14
SysEvtMgrGlobalsType.penDown = 16
SysEvtMgrGlobalsType.displayingBatteryAlert = 16
SysEvtMgrGlobalsType.lastPenX = 16
SysEvtMgrGlobalsType.lastPenY = 18
SysEvtMgrGlobalsType.lastPenDown = 20
SysEvtMgrGlobalsType.needRemoteScrUpdate = 20
SysEvtMgrGlobalsType.gremlinsFlags = 20
SysEvtMgrGlobalsType.idle = 20
			| UI\WindowNew.h
up	=	0
down	=	1
left	=	3
right	=	4
			| windowFormats
screenFormat	=	0
genericFormat	=	1
			| ScrOperation
scrCopy	=	0
scrAND	=	1
scrANDNOT	=	2
scrXOR	=	3
scrOR	=	4
scrCopyNOT	=	5
			| patterns
blackPattern	=	0
whitePattern	=	1
grayPattern	=	2
customPattern	=	3
grayHLinePattern	=	0xAA
			| underlineModes
noUnderline	=	0
grayUnderline	=	1
solidUnderline	=	2
BitmapFlagsType_compressed	=	0x0001
BitmapFlagsType_hasColorTable	=	0x0002
BitmapType.width = 0
BitmapType.height = 2
BitmapType.rowBytes = 4
BitmapType.flags = 6
BitmapType.pixelSize = 8
BitmapType.version = 8
BitmapType.nextDepthOffset = 8
BitmapType.reserved = 12
BitmapType.Bits = 12
RGBColorType.unused = 0
RGBColorType.red = 0
RGBColorType.green = 0
RGBColorType.blue = 0
ColorTableType.numEntries = 0
ColorTableType.entry.RGBColorTy = 2
GraphicStateType.grafMode = 0
GraphicStateType.patternMode = 0
GraphicStateType.pattern = 0
GraphicStateType.customPtn = 2
GraphicStateType.fontId = 10
GraphicStateType.padding1 = 10
GraphicStateType.font = 10
GraphicStateType.underlineMode = 14
GraphicStateType.foreColor.RGBColorTy = 16
GraphicStateType.backColor.RGBColorTy = 16
			|typedef union {
			|	struct {
			|		Word cornerDiam   : 8;            // corner diameter, max 38
			|		Word reserved_3   : 3;
			|		Word threeD			: 1;			;	// Draw 3D button    ;
			|		Word s;hadowWidth  : 2;            // Width of shadow
			|		Word w;idth        : 2;            // Width frame
			|	} bits;;
			|	Word wo;rd;								;// IMPORTANT: INITIALIZE word to zero before setting bits!
			|;noFrame	equ	0
			|impleFrame	equ	1
			|ectangleFrame	equ	1
			|imple3DFrame	equ	$0012
			|oundFrame	equ	$0401
			|oldRoundFrame	equ	$0702
			|opupFrame	equ	$0205
			|ialogFrame	equ	$0302
			|enuFrame	equ	popupFrame
			|;WindowFlagsType_format_shift     equ 0
			|indowFlagsType_format_count     equ 1
			|indowFlagsType_format_mask      equ $00000001
			|indowFlagsType_offscreen_shift  equ 1
			|indowFlagsType_offscreen_count  equ 1
			|indowFlagsType_offscreen_mask   equ $00000002
			|indowFlagsType_modal_shift      equ 2
			|indowFlagsType_modal_count      equ 1
			|indowFlagsType_modal_mask       equ $00000004
			|indowFlagsType_focusable_shift  equ 3
			|indowFlagsType_focusable_count  equ 1
			|indowFlagsType_focusable_mask   equ $00000008
			|indowFlagsType_enabled_shift    equ 4
			|indowFlagsType_enabled_count    equ 1
			|indowFlagsType_enabled_mask     equ $00000010
			|indowFlagsType_visible_shift    equ 5
			|indowFlagsType_visible_count    equ 1
			|indowFlagsType_visible_mask     equ $00000020
			|indowFlagsType_dialog_shift     equ 6
			|indowFlagsType_dialog_count     equ 1
			|indowFlagsType_dialog_mask      equ $00000040
			|indowFlagsType_compressed_shift equ 7
			|indowFlagsType_compressed_count equ 1
			|indowFlagsType_compressed_mask  equ $00000080
			|indowFlagsType_reserved_shift   equ 8
			|indowFlagsType_reserved_count   equ 8
			|indowFlagsType_reserved_mask    equ $0000ff00
			|;struct GDeviceType
			|baseAddr.l
			|width.w
			|height.w
			|rowBytes.w
			|pixelSize.b
			|version.b
			|flages.w
			|	forDriver:1.w
			|	dynamic:1.w
			|	compressed:1.w
			|	flags:13.w
			|	cTableP.l
			|endstruct
WindowType.displayWidthV20 = 0
WindowType.displayHeightV20 = 2
WindowType.displayAddrV20 = 4
WindowType.windowFlags = 8
WindowType.windowBounds.RectangleTy = 10
WindowType.clippingBounds.AbsRectTy = 10
WindowType.gDeviceP = 10
WindowType.frameType = 14
WindowType.gstate = 16
WindowType.nextWindow = 20
			| UI\Control.h
ControlAttrType_usable_shift	=	0
ControlAttrType_usable_count	=	1
ControlAttrType_usable_mask	=	0x00000001
ControlAttrType_enabled_shift	=	1
ControlAttrType_enabled_count	=	1
ControlAttrType_enabled_mask	=	0x00000002
ControlAttrType_visible_shift	=	2
ControlAttrType_visible_count	=	1
ControlAttrType_visible_mask	=	0x00000004
ControlAttrType_on_shift	=	3
ControlAttrType_on_count	=	1
ControlAttrType_on_mask	=	0x00000008
ControlAttrType_leftAnchor_shift	=	4
ControlAttrType_leftAnchor_count	=	1
ControlAttrType_leftAnchor_mask	=	0x00000010
ControlAttrType_frame_shift	=	5
ControlAttrType_frame_count	=	3
ControlAttrType_frame_mask	=	0x000000e0
			|controlStyles
buttonCtl	=	0
pushButtonCtl	=	1
checkboxCtl	=	2
popupTriggerCtl	=	3
selectorTriggerCtl	=	4
repeatingButtonCtl	=	5
			| buttonFrames
noButtonFrame	=	0
standardButtonFrame	=	1
boldButtonFrame	=	2
rectangleButtonFrame	=	3
ControlType.id = 0
ControlType.bounds.RectangleTy = 2
ControlType.text = 2
ControlType.attr = 6
ControlType.style = 8
ControlType.font = 10
ControlType.group = 10
			| UI\Category.h
AppInfoType.renamedCategories = 0
AppInfoType.categoryLabels.2 = 2
AppInfoType.categoryUniqIDs. = 2
AppInfoType.lastUniqID = 2
			| UI\CharAttr.h
_XA	=	0x200
_XS	=	0x100
_BB	=	0x80
_CN	=	0x40
_DI	=	0x20
_LO	=	0x10
_PU	=	0x08
_SP	=	0x04
_UP	=	0x02
_XD	=	0x01
			| UI\Chars.h
downArrowChr	=	0x1F
upArrowChr	=	0x1E
leftArrowChr	=	0x1C
rightArrowChr	=	0x1D
pageUpChr	=	0x0B
pageDownChr	=	0x0C
lowBatteryChr	=	0x0101
enterDebuggerChr	=	0x0102
nextFieldChr	=	0x0103
startConsoleChr	=	0x0104
menuChr	=	0x0105
commandChr	=	0x0106
confirmChr	=	0x0107
launchChr	=	0x0108
keyboardChr	=	0x0109
findChr	=	0x010A
calcChr	=	0x010B
prevFieldChr	=	0x010C
alarmChr	=	0x010D
ronamaticChr	=	0x010E
graffitiReferenceChr	=	0x010F
keyboardAlphaChr	=	0x0110
keyboardNumericChr	=	0x0111
lockChr	=	0x0112
backlightChr	=	0x0113
autoOffChr	=	0x0114
exgTestChr	=	0x0115
sendDataChr	=	0x0116
irReceiveChr	=	0x0117
hardKeyMin	=	0x0200
hardKeyMax	=	0x02FF
hard1Chr	=	0x0204
hard2Chr	=	0x0205
hard3Chr	=	0x0206
hard4Chr	=	0x0207
hardPowerChr	=	0x0208
hardCradleChr	=	0x0209
hardCradle2Chr	=	0x020A
nullChr	=	0x00
backspaceChr	=	0x08
tabChr	=	0x09
linefeedChr	=	0x0A
crChr	=	0x0D
colonChr	=	':'
periodChr	=	'.'
commaChr	=	','
quoteChr	=	'"'
returnChr	=	0x0D
escapeChr	=	0x1B
spaceChr	=	0x20
lastAsciiChr	=	0xFF
numericSpaceChr	=	0x80
cutChr	=	0x12D
copyChr	=	0x12E
pasteChr	=	0x12F
lowSingleCommaQuoteChr	=	0x82
scriptFChr	=	0x83
lowDblCommaQuoteChr	=	0x84
horizEllipsisChr	=	0x85
daggerChr	=	0x86
dblDaggerChr	=	0x87
circumflexChr	=	0x88
perMilleChr	=	0x89
upSHacekChr	=	0x8A
leftSingleGuillemetChr	=	0x8B
upOEChr	=	0x8C
clubChr	=	0x8E
heartChr	=	0x8F
spadeChr	=	0x90
singleOpenCommaQuoteChr	=	0x91
singleCloseCommaQuoteChr	=	0x92
dblOpenCommaQuoteChr	=	0x93
dblCloseCommaQuoteChr	=	0x94
bulletChr	=	0x95
enDashChr	=	0x96
emDashChr	=	0x97
spacingTildeChr	=	0x98
trademarkChr	=	0x99
lowSHacekChr	=	0x9A
rightSingleGuillemetChr	=	0x9B
lowOEChr	=	0x9C
commandStrokeChr	=	0x9D
shortcutStrokeChr	=	0x9E
upYDiaeresisChr	=	0x9F
nonBreakSpaceChr	=	0xA0
invertedExclamationChr	=	0xA1
centChr	=	0xA2
poundChr	=	0xA3
currencyChr	=	0xA4
yenChr	=	0xA5
brokenVertBarChr	=	0xA6
sectionChr	=	0xA7
spacingDiaeresisChr	=	0xA8
copyrightChr	=	0xA9
feminineOrdinalChr	=	0xAA
leftGuillemetChr	=	0xAB
notChr	=	0xAC
softHyphenChr	=	0xAD
registeredChr	=	0xAE
spacingMacronChr	=	0xAF
degreeChr	=	0xB0
plusMinusChr	=	0xB1
superscript2Chr	=	0xB2
superscript3Chr	=	0xB3
spacingAcuteChr	=	0xB4
microChr	=	0xB5
paragraphChr	=	0xB6
middleDotChr	=	0xB7
spacingCedillaChr	=	0xB8
superscript1Chr	=	0xB9
masculineOrdinalChr	=	0xBA
rightGuillemetChr	=	0xBB
fractOneQuarterChr	=	0xBC
fractOneHalfChr	=	0xBD
fractThreeQuartersChr	=	0xBE
invertedQuestionChr	=	0xBF
upAGraveChr	=	0xC0
upAAcuteChr	=	0xC1
upACircumflexChr	=	0xC2
upATildeChr	=	0xC3
upADiaeresisChr	=	0xC4
upARingChr	=	0xC5
upAEChr	=	0xC6
upCCedillaChr	=	0xC7
upEGraveChr	=	0xC8
upEAcuteChr	=	0xC9
upECircumflexChr	=	0xCA
upEDiaeresisChr	=	0xCB
upIGraveChr	=	0xCC
upIAcuteChr	=	0xCD
upICircumflexChr	=	0xCE
upIDiaeresisChr	=	0xCF
upEthChr	=	0xD0
upNTildeChr	=	0xD1
upOGraveChr	=	0xD2
upOAcuteChr	=	0xD3
upOCircumflexChr	=	0xD4
upOTildeChr	=	0xD5
upODiaeresisChr	=	0xD6
multiplyChr	=	0xD7
upOSlashChr	=	0xD8
upUGraveChr	=	0xD9
upUAcuteChr	=	0xDA
upUCircumflexChr	=	0xDB
upUDiaeresisChr	=	0xDC
upYAcuteChr	=	0xDD
upThorn	=	0xDE
lowSharpSChr	=	0xDF
lowAGraveChr	=	0xE0
lowAAcuteChr	=	0xE1
lowACircumflexChr	=	0xE2
lowATildeChr	=	0xE3
lowADiaeresisChr	=	0xE4
lowARingChr	=	0xE5
lowAEChr	=	0xE6
lowCCedillaChr	=	0xE7
lowEGraveChr	=	0xE8
lowEAcuteChr	=	0xE9
lowECircumflexChr	=	0xEA
lowEDiaeresisChr	=	0xEB
lowIGraveChr	=	0xEC
lowIAcuteChr	=	0xED
lowICircumflexChr	=	0xEE
lowIDiaeresisChr	=	0xEF
lowEthChr	=	0xF0
lowNTildeChr	=	0xF1
lowOGraveChr	=	0xF2
lowOAcuteChr	=	0xF3
lowOCircumflexChr	=	0xF4
lowOTildeChr	=	0xF5
lowODiaeresisChr	=	0xF6
divideChr	=	0xF7
lowOSlashChr	=	0xF8
lowUGraveChr	=	0xF9
lowUAcuteChr	=	0xFA
lowUCircumflexChr	=	0xFB
lowUDiaeresisChr	=	0xFC
lowYAcuteChr	=	0xFD
lowThorn	=	0xFE
lowYDiaeresisChr	=	0xFF
			| symbolChars
symbolLeftArrow	=	3
symbolRightArrow	=	4
symbolUpArrow	=	5
symbolDownArrow	=	6
symbolSmallDownArrow	=	7
symbolSmallUpArrow	=	8
symbolMemo	=	9
symbolHelp	=	10
symbolNote	=	11
symbolNoteSelected	=	12
symbolCapsLock	=	13
symbolNumLock	=	14
symbolShiftUpper	=	15
symbolShiftPunc	=	16
symbolShiftExt	=	17
symbolShiftNone	=	18
symbolNoTime	=	19
symbolAlarm	=	20
symbolRepeat	=	21
symbolCheckMark	=	22
			|symbol7Chars
symbol7ScrollUp	=	1
symbol7ScrollDown	=	2
symbol7ScrollUpDisabled	=	3
symbol7ScrollDownDisabled	=	4
			| symbol11Chars
symbolCheckboxOff	=	0
symbolCheckboxOn	=	1
symbol11LeftArrow	=	2
symbol11RightArrow	=	3
			| System\Keyboard.h
kbdReturnKey	=	linefeedChr
kbdTabKey	=	tabChr
kbdBackspaceKey	=	backspaceChr
kbdShiftKey	=	2
kbdCapsKey	=	1
kbdNoKey	=	0xff
			| KeyboardType
kbdAlpha	=	0
kbdNumbersAndPunc	=	1
kbdAccent	=	2
kbdDefault	=	0xff
			| UI\ClipBoard.h
numClipboardForamts	=	3
cbdMaxTextLength	=	1000
			| clipboardFormats
clipboardText	=	0
clipboardInk	=	1
clipboardBitmap	=	2
ClipboardItem.item = 0
ClipboardItem.length = 4
			| UI\Day.h
			| SelectDayType
selectDayByDay	=	0
selectDayByWeek	=	1
selectDayByMonth	=	2
DaySelectorType.bounds.RectangleTy = 0
DaySelectorType.visible = 0
DaySelectorType.visibleMonth = 2
DaySelectorType.visibleYear = 4
DaySelectorType.selected.DateTimeTy = 6
DaySelectorType.selectDayBy = 6
DaySelectorType.pad = 6
			| UI\Event.H
			| events
nilEvent	=	0
penDownEvent	=	1
penUpEvent	=	2
penMoveEvent	=	3
keyDownEvent	=	4
winEnterEvent	=	5
winExitEvent	=	6
ctlEnterEvent	=	7
ctlExitEvent	=	8
ctlSelectEvent	=	9
ctlRepeatEvent	=	10
lstEnterEvent	=	11
lstSelectEvent	=	12
lstExitEvent	=	13
popSelectEvent	=	14
fldEnterEvent	=	15
fldHeightChangedEvent	=	16
fldChangedEvent	=	17
tblEnterEvent	=	18
tblSelectEvent	=	19
daySelectEvent	=	20
menuEvent	=	21
appStopEvent	=	22
frmLoadEvent	=	23
frmOpenEvent	=	24
frmGotoEvent	=	25
frmUpdateEvent	=	26
frmSaveEvent	=	27
frmCloseEvent	=	28
			|tblExitEvent	equ	29	; PalmOS 1.0
frmTitleEnterEvent	=	29
frmTitleSelectEvent	=	30
tblExitEvent	=	31
sclEnterEvent	=	32
sclExitEvent	=	33
sclRepeatEvent	=	34
firstUserEvent	=	32767
shiftKeyMask	=	0x0001
capsLockMask	=	0x0002
numLockMask	=	0x0004
commandKeyMask	=	0x0008
optionKeyMask	=	0x0010
controlKeyMask	=	0x0020
autoRepeatKeyMask	=	0x0040
doubleTapKeyMask	=	0x0080
poweredOnKeyMask	=	0x0100
appEvtHookKeyMask	=	0x0200
libEvtHookKeyMask	=	0x0400
evtWaitForever	=	-1
EventType.eType = 0
EventType.penDown = 2
EventType.screenX = 4
EventType.screenY = 6
EventType.data. = 8
			| union data
generic.data1 = 0
generic.data2 = 2
generic.data3 = 4
generic.data4 = 6
generic.data5 = 8
generic.data6 = 10
generic.data7 = 12
generic.data8 = 14
penUp.start.PointTy = 0
penUp.end.PointTy = 0
keyDown.chr = 0
keyDown.keyCode = 2
keyDown.modifiers = 4
winEnter.enterWindow = 0
winEnter.exitWindow = 4
winExit.enterWindow = 0
winExit.exitWindow = 4
ctlEnter.controlID = 0
ctlEnter.pControl = 2
ctlSelect.controlID = 0
ctlSelect.pControl = 2
ctlSelect.on = 6
ctlSelect.bPad = 6
ctlRepeat.controlID = 0
ctlRepeat.pControl = 2
ctlRepeat.time = 6
fldEnter.fieldID = 0
fldEnter.pField = 2
fldHeightChanged.fieldID = 0
fldHeightChanged.pField = 2
fldHeightChanged.newHeight = 6
fldHeightChanged.currentPos = 8
fldChanged.fieldID = 0
fldChanged.pField = 2
fldExit.fieldID = 0
fldExit.pField = 2
lstEnter.listID = 0
lstEnter.pList = 2
lstEnter.selection = 6
lstExit.listID = 0
lstExit.pList = 2
lstSelect.listID = 0
lstSelect.pList = 2
lstSelect.selection = 6
tblEnter.tableID = 0
tblEnter.pTable = 2
tblEnter.row = 6
tblEnter.column = 8
tblExit.tableID = 0
tblExit.pTable = 2
tblExit.row = 6
tblExit.column = 8
tblSelect.tableID = 0
tblSelect.pTable = 2
tblSelect.row = 6
tblSelect.column = 8
frmLoad.formID = 0
frmOpen.formID = 0
frmGoto.formID = 0
frmGoto.recordNum = 2
frmGoto.matchPos = 4
frmGoto.matchLen = 6
frmGoto.matchFieldNum = 8
frmGoto.matchCustom = 10
frmClose.formID = 0
frmUpdate.formID = 0
frmUpdate.updateCode = 2
frmTitleEnter.formID = 0
frmTitleSelect.formID = 0
daySelect.pSelector = 0
daySelect.selection = 4
daySelect.useThisDate = 6
daySelect.bPad = 6
menu.itemID = 0
popSelect.controlID = 0
popSelect.controlP = 2
popSelect.listID = 6
popSelect.listP = 8
popSelect.selection = 12
popSelect.priorSelection = 14
sclEnter.scrollBarID = 0
sclEnter.pScrollBar = 2
sclExit.scrollBarID = 0
sclExit.pScrollBar = 2
sclExit.value = 6
sclExit.newValue = 8
sclRepeat.scrollBarID = 0
sclRepeat.pScrollBar = 2
sclRepeat.value = 6
sclRepeat.newValue = 8
sclRepeat.time = 10
EventStoreType.event = 0
EventStoreType.id = 2
			| System\INetMgr.h
inetCreator	=	0x696e6574
inetLibFtrCreator	=	inetCreator
inetFtrNumVersion	=	0
inetLibType	=	0x6c696272
inetOpenFlagOKWireless	=	0x00000001
inetOpenFlagOKWireline	=	0x00000002
inetOpenFlagPreferWireless	=	0x00000004
inetErrTooManyClients	=	inetErrorClass|1
inetErrHandleInvalid	=	inetErrorClass|2
inetErrParamsInvalid	=	inetErrorClass|3
inetErrURLVersionInvalid	=	inetErrorClass|4
inetErrURLBufTooSmall	=	inetErrorClass|5
inetErrURLInvalid	=	inetErrorClass|6
inetErrTooManySockets	=	inetErrorClass|7
inetErrNoRequestCreated	=	inetErrorClass|8
inetErrNotConnected	=	inetErrorClass|9
inetErrInvalidRequest	=	inetErrorClass|10
inetErrNeedTime	=	inetErrorClass|11
inetErrHostnameInvalid	=	inetErrorClass|12
inetErrInvalidPort	=	inetErrorClass|13
inetErrInvalidHostAddr	=	inetErrorClass|14
inetErrNilBuffer	=	inetErrorClass|15
inetErrConnectTimeout	=	inetErrorClass|16
inetErrResolveTimeout	=	inetErrorClass|17
inetErrSendReqTimeout	=	inetErrorClass|18
inetErrReadTimeout	=	inetErrorClass|19
inetErrBufTooSmall	=	inetErrorClass|20
inetErrSchemeNotSupported	=	inetErrorClass|21
inetErrInvalidResponse	=	inetErrorClass|22
			| INetSchemeEnum
inetSchemeUnknown	=	-1
inetSchemeDefault	=	0
inetSchemeHTTP	=	1
inetSchemeHTTPS	=	2
inetSchemeFTP	=	3
inetSchemeGopher	=	4
inetSchemeFile	=	5
inetSchemeNews	=	6
inetSchemeMailTo	=	7
inetSchemeMail	=	8
inetSchemeFirst	=	inetSchemeHTTP
inetSchemeLast	=	inetSchemeMail
INetURLType.version = 0
INetURLType.schemeP = 2
INetURLType.schemeLen = 6
INetURLType.schemeEnum = 8
INetURLType.hostnameP = 10
INetURLType.hostnameLen = 14
INetURLType.port = 16
INetURLType.usernameP = 18
INetURLType.usernameLen = 22
INetURLType.passwordP = 24
INetURLType.passwordLen = 28
INetURLType.pathP = 30
INetURLType.pathLen = 34
INetURLType.extraInfoP = 36
INetURLType.extraInfoLen = 40
			| INetProxyEnum
inetProxyNone	=	0
inetProxyJerry	=	1
			| INetSettingEnum;
inetSettingProxyType	=	0
inetSettingJerryProxyName	=	1
inetSettingJerryProxyPort	=	2
inetSettingJerryProxyAddrGrMAN	=	3
inetSettingJerryProxyAddrMAN	=	4
inetSettingWirelessNetwork	=	5
inetSettingSockContext	=	6
inetSettingLast	=	7
			| INetStatusEnum;
inetStatusNew	=	0
inetStatusResolvingName	=	1
inetStatusNameResolved	=	2
inetStatusConnecting	=	3
inetStatusConnected	=	4
inetStatusSendingRequest	=	5
inetStatusWaitingForResponse	=	6
inetStatusReceivingResponse	=	7
inetStatusResponseReceived	=	8
inetStatusClosingConnection	=	9
			| INetHTTPAttrEnum;
inetHTTPAttrCommErr	=	0
inetHTTPAttrEntityURL	=	1
inetHTTPAttrReqAuthorization	=	2
inetHTTPAttrReqFrom	=	3
inetHTTPAttrReqIfModifiedSince	=	4
inetHTTPAttrReqReferer	=	5
inetHTTPAttrRspAll	=	6
inetHTTPAttrRspVersion	=	7
inetHTTPAttrStatusCode	=	8
inetHTTPAttrReason	=	9
inetHTTPAttrDate	=	10
inetHTTPAttrNoCache	=	11
inetHTTPAttrPragma	=	12
inetHTTPAttrServer	=	13
inetHTTPAttrWWWAuthentication	=	14
inetHTTPAttrContentAllow	=	15
inetHTTPAttrContentEncoding	=	16
inetHTTPAttrContentLength	=	17
inetHTTPAttrContentPtr	=	18
inetHTTPAttrContentType	=	19
inetHTTPAttrContentExpires	=	20
inetHTTPAttrContentLastModified	=	21
inetHTTPAttrContentLocation	=	22
inetSockReadyEvent	=	firstUserEvent
inetSockStatusChangeEvent	=	firstUserEvent+1
inetLastEvent	=	firstUserEvent+1
INetEventType.eType = 0
INetEventType.penDown = 0
INetEventType.screenX = 0
INetEventType.screenY = 2
INetEventType.union. = 4
generic.data1 = 0
generic.data2 = 2
generic.data3 = 4
generic.data4 = 6
generic.data5 = 8
generic.data6 = 10
generic.data7 = 12
generic.data8 = 14
inetSockReady.sockH = 0
inetSockReady.context = 4
inetSockReady.inputReady = 8
inetSockReady.outputReady = 8
inetSockStatusChange.sockH = 0
inetSockStatusChange.context = 4
inetSockStatusChange.status = 8
inetSockStatusChange.sockErr = 10
			| INetLibTrapNumberEnum;
inetLibTrapSettingGet	=	sysLibTrapCustom
inetLibTrapSettingSet	=	sysLibTrapCustom+1
inetLibTrapGetEvent	=	sysLibTrapCustom+2
inetLibTrapURLOpen	=	sysLibTrapCustom+3
inetLibTrapSockRead	=	sysLibTrapCustom+4
inetLibTrapSockWrite	=	sysLibTrapCustom+5
inetLibTrapSockOpen	=	sysLibTrapCustom+6
inetLibTrapSockClose	=	sysLibTrapCustom+7
inetLibTrapSockStatus	=	sysLibTrapCustom+8
inetLibTrapSockSettingGet	=	sysLibTrapCustom+9
inetLibTrapSockSettingSet	=	sysLibTrapCustom+10
inetLibTrapSockConnect	=	sysLibTrapCustom+11
inetLibTrapURLCrack	=	sysLibTrapCustom+12
inetLibTrapSockHTTPReqCreate	=	sysLibTrapCustom+13
inetLibTrapSockHTTPAttrSet	=	sysLibTrapCustom+14
inetLibTrapSockHTTPReqSend	=	sysLibTrapCustom+15
inetLibTrapSockHTTPAttrGet	=	sysLibTrapCustom+16
inetLibTrapSockMailReqCreate	=	sysLibTrapCustom+17
inetLibTrapSockMailAttrSet	=	sysLibTrapCustom+18
inetLibTrapSockMailReqAdd	=	sysLibTrapCustom+19
inetLibTrapSockMailReqSend	=	sysLibTrapCustom+20
inetLibTrapSockMailAttrGet	=	sysLibTrapCustom+21
inetLibTrapSockMailQueryProgress	=	sysLibTrapCustom+22
inetLibTrapLast	=	sysLibTrapCustom+23
			| System\INetMgrMail.h
			| inetMailAttrEnum
inetMailAttrCommErr	=	0
inetMailAttrReqEncrypted	=	1
INetMailUIDType.hi = 0
INetMailUIDType.lo = 2
			| INetMailCmdEnum;
inetMailCmdNew	=	0
inetMailCmdSend	=	1
inetMailCmdGetMore	=	2
inetMailCmdServer	=	3
inetMailMaxUsername	=	32
inetMailMaxPassword	=	32
INetMailNewType.id.INetMailUIDTy = 0
INetMailNewType.previewSize = 0
INetMailNewType.headerFieldsP = 4
INetMailNewType.availMemory = 8
INetMailNewType.truncationSize = 12
INetMailNewType.networkID = 16
INetMailNewType.username. = 20
INetMailNewType.password. = 20
INetMailSendType.priority = 0
INetMailSendType.confirmRead = 2
INetMailSendType.confirmDelivery = 2
INetMailSendType.attachmentCount = 2
INetMailSendType.attachmentsP = 4
INetMailSendType.msgSize = 8
INetMailSendType.msgP = 12
INetMailGetMoreType.id.INetMailUIDTy = 0
INetMailGetMoreType.bodyEndOffset = 0
INetMailGetMoreType.headerFieldsP = 4
INetMailServerType.serverCmd = 0
INetMailServerType.serverParamsLen = 4
INetMailServerType.serverParamsP = 8
inetMailContentJerry	=	0
INetMailHeaderType.proxyErr = 0
INetMailHeaderType.serverErr = 2
INetMailHeaderType.rspSize = 4
INetMailHeaderType.serverErr = 8
INetMailHeaderType.contentType = 10
INetMailHeaderType.newMsgs = 12
INetMailHeaderType.updMsgs = 14
INetMailHeaderType.moreMailAvail = 16
INetMailHeaderType.pad = 16
			| INetMailRspEnum;
inetMailRspEnd	=	0
inetMailRspNewMsg	=	1
inetMailRspMsgAttachment	=	2
inetMailRspUpdMsg	=	3
inetMailRspAck	=	4
INetMailRspType.kind = 0
INetMailRspType.dataSize = 2
INetMailRspType.union. = 6
generic.generic. = 0
newMsg.id.INetMailUIDTy = 0
newMsg.addrType = 0
newMsg.bodyEndOffset = 2
newMsg.priority = 6
newMsg.serverMsgSize = 8
newMsg.serverNoteID = 12
newMsg.attachmentCount = 14
newMsg.timeStamp = 16
attachment.type = 0
updMsg.id.INetMailUIDTy = 0
updMsg.bodyEndOffset = 0
updMsg.serverNoteID = 4
updMsg.attachmentCount = 6
ack.cmd = 0
ack.serverErr = 2
ack.id.INetMailUIDTy = 6
ack.dataType = 6
			| UI\Font.h
FontCharInfoType.offset = 0
FontCharInfoType.width = 0
FontType.fontType = 0
FontType.firstChar = 2
FontType.lastChar = 4
FontType.maxWidth = 6
FontType.kernMax = 8
FontType.nDescent = 10
FontType.fRectWidth = 12
FontType.fRectHeight = 14
FontType.owTLoc = 16
FontType.ascent = 18
FontType.descent = 20
FontType.leading = 22
FontType.rowWords = 24
			| fontID
stdFont	=	0
boldFont	=	1
largeFont	=	2
symbolFont	=	3
symbol11Font	=	4
symbol7Font	=	5
ledFont	=	6
largeBoldFont	=	7
fntAppFontCustomBase	=	0x80
checkboxFont	=	symbol11Font
			| UI\Find.h
maxFinds	=	9
maxFindStrLen	=	16
FindMatchType.appCardNo = 0
FindMatchType.appDbID = 2
FindMatchType.foundInCaller = 6
FindMatchType.dbCardNo = 8
FindMatchType.dbID = 10
FindMatchType.recordNum = 14
FindMatchType.matchPos = 16
FindMatchType.matchFieldNum = 18
FindMatchType.matchCustom = 20
FindParamsType.dbAccesMode = 0
FindParamsType.recordNum = 2
FindParamsType.more = 4
FindParamsType.strAsTyped. = 4
FindParamsType.strToFind. = 4
FindParamsType.pad = 4
FindParamsType.numMatches = 4
FindParamsType.lineNumber = 6
FindParamsType.continuation = 8
FindParamsType.searchedCaller = 8
FindParamsType.callerAppDbID = 8
FindParamsType.callerAppCardNo = 12
FindParamsType.appDbID = 14
FindParamsType.appCardNo = 18
FindParamsType.newSearch = 20
FindParamsType.searchState.DmSearchStateTy = 22
FindParamsType.match0.FindMatchTy = 22
FindParamsType.match1.FindMatchTy = 22
FindParamsType.match2.FindMatchTy = 22
FindParamsType.match3.FindMatchTy = 22
FindParamsType.match4.FindMatchTy = 22
FindParamsType.match5.FindMatchTy = 22
FindParamsType.match6.FindMatchTy = 22
FindParamsType.match7.FindMatchTy = 22
FindParamsType.match8.FindMatchTy = 22
GoToParamsType.searchStrLen = 0
GoToParamsType.dbCardNo = 2
GoToParamsType.dbID = 4
GoToParamsType.recordNum = 8
GoToParamsType.matchPos = 10
GoToParamsType.matchFieldNum = 12
GoToParamsType.matchCustom = 14
			| UI\Field.h
maxFieldTextLen	=	0x7fff
maxFieldLines	=	11
			| justifications
leftAlign	=	0
centerAlign	=	1
rightAlign	=	2
undoBufferSize	=	100
			| UndoMode
undoNone	=	0
undoTyping	=	1
undoBackspace	=	2
undoDelete	=	3
undoPaste	=	4
undoCut	=	5
FieldUndoType.mode = 0
FieldUndoType.start = 2
FieldUndoType.end = 4
FieldUndoType.bufferLen = 6
FieldUndoType.buffer = 8
FieldAttrType_usable_shift	=	0
FieldAttrType_usable_count	=	1
FieldAttrType_usable_mask	=	0x00000001
FieldAttrType_visible_shift	=	1
FieldAttrType_visible_count	=	1
FieldAttrType_visible_mask	=	0x00000002
FieldAttrType_editable_shift	=	2
FieldAttrType_editable_count	=	1
FieldAttrType_editable_mask	=	0x00000004
FieldAttrType_singleLine_shift	=	3
FieldAttrType_singleLine_count	=	1
FieldAttrType_singleLine_mask	=	0x00000008
FieldAttrType_hasFocus_shift	=	4
FieldAttrType_hasFocus_count	=	1
FieldAttrType_hasFocus_mask	=	0x00000010
FieldAttrType_dynamicSize_shift	=	5
FieldAttrType_dynamicSize_count	=	1
FieldAttrType_dynamicSize_mask	=	0x00000020
FieldAttrType_insPtVisible_shift	=	6
FieldAttrType_insPtVisible_count	=	1
FieldAttrType_insPtVisible_mask	=	0x00000040
FieldAttrType_dirty_shift	=	7
FieldAttrType_dirty_count	=	1
FieldAttrType_dirty_mask	=	0x00000080
FieldAttrType_underlined_shift	=	8
FieldAttrType_underlined_count	=	2
FieldAttrType_underlined_mask	=	0x00000300
FieldAttrType_justification_shift	=	10
FieldAttrType_justification_count	=	2
FieldAttrType_justification_mask	=	0x00000c00
FieldAttrType_autoShift_shift	=	12
FieldAttrType_autoShift_count	=	1
FieldAttrType_autoShift_mask	=	0x00001000
FieldAttrType_hasScrollBar_shift	=	13
FieldAttrType_hasScrollBar_count	=	1
FieldAttrType_hasScrollBar_mask	=	0x00002000
FieldAttrType_numeric_shift	=	14
FieldAttrType_numeric_count	=	1
FieldAttrType_numeric_mask	=	0x00004000
LineInfoType.start = 0
LineInfoType.length = 0
FieldType.id = 0
FieldType.rect.RectangleTy = 2
FieldType.attr = 2
FieldType.text = 4
FieldType.textHandle = 8
FieldType.lines = 12
FieldType.textLen = 16
FieldType.textBlockSize = 18
FieldType.maxChars = 20
FieldType.selFirstPos = 22
FieldType.selLastPos = 24
FieldType.insPtXPos = 26
FieldType.insPtYPos = 28
FieldType.fontID = 30
FieldType.pad = 30
			| UI\Form.h
noFocus	=	0xffff
frmRedrawUpdateCode	=	0x8000
			| alertTypes
informationAlert	=	0
confirmationAlert	=	1
warningAlert	=	2
errorAlert	=	3
AlertTemplateType.alertType = 0
AlertTemplateType.helpRscID = 2
AlertTemplateType.numButtons = 4
AlertTemplateType.defaultButton = 6
			| formObjects
frmFieldObj	=	0
frmControlObj	=	1
frmListObj	=	2
frmTableObj	=	3
frmBitmapObj	=	4
frmLineObj	=	5
frmFrameObj	=	6
frmRectangleObj	=	7
frmLabelObj	=	8
frmTitleObj	=	9
frmPopupObj	=	10
frmGraffitiStateObj	=	11
frmGadgetObj	=	12
frmScrollBarObj	=	13
FormObjAttrType_usable_shift	=	0
FormObjAttrType_usable_count	=	1
FormObjAttrType_usable_mask	=	0x00000001
FormBitmapType.attr = 0
FormBitmapType.pos.PointTy = 2
FormBitmapType.rscID = 2
FormLineType.attr = 0
FormLineType.point1.PointTy = 2
FormLineType.point2.PointTy = 2
FormFrameType.id = 0
FormFrameType.attr = 2
FormFrameType.rect.RectangleTy = 4
FormFrameType.frameType = 4
FormRectangleType.attr = 0
FormRectangleType.rect.RectangleTy = 2
FormLabelType.id = 0
FormLabelType.pos.PointTy = 2
FormLabelType.attr = 2
FormLabelType.pad = 2
FormLabelType.fontID = 2
FormLabelType.text = 4
FormTitleType.rect.RectangleTy = 0
FormTitleType.text = 0
FormPopupType.controlID = 0
FormPopupType.listID = 2
FrmGraffitiStateType.pos.PointTy = 0
FormGadgetType.id = 0
FormGadgetType.attr = 2
FormGadgetType.rect.RectangleTy = 4
FormGadgetType.data = 4
FormObjListType.objectType = 0
FormObjListType.object = 2
FormAttrType_usable_shift	=	0
FormAttrType_usable_count	=	1
FormAttrType_usable_mask	=	0x00000001
FormAttrType_visible_shift	=	1
FormAttrType_visible_count	=	1
FormAttrType_visible_mask	=	0x00000002
FormAttrType_dirty_shift	=	2
FormAttrType_dirty_count	=	1
FormAttrType_dirty_mask	=	0x00000004
FormAttrType_saveBehind_shift	=	3
FormAttrType_saveBehind_count	=	1
FormAttrType_saveBehind_mask	=	0x00000008
FormAttrType_graffitiShift_shift	=	4
FormAttrType_graffitiShift_count	=	1
FormAttrType_graffitiShift_mask	=	0x00000010
FormType.window.WindowTy = 0
FormType.formId = 0
FormType.attr = 2
FormType.bitsBehindForm = 4
FormType.handler = 8
FormType.focus = 12
FormType.defaultButton = 14
FormType.helpRscId = 16
FormType.menuRscId = 18
FormType.numObjects = 20
FormType.objects = 22
FormActiveStateType.data. = 0
			| UI\GraffitiShift.h
glfCapsLock	=	0x01
glfNumLock	=	0x02
			| GsiShiftState
gsiShiftNone	=	0
gsiNumLock	=	1
gsiCapsLock	=	2
gsiShiftPunctuation	=	3
gsiShiftExtended	=	4
gsiShiftUpper	=	5
gsiShiftLower	=	6
			| UI\List.h
noListSelection	=	0xffff
ListAttrType_usable_shift	=	0
ListAttrType_usable_count	=	1
ListAttrType_usable_mask	=	0x00000001
ListAttrType_enabled_shift	=	1
ListAttrType_enabled_count	=	1
ListAttrType_enabled_mask	=	0x00000002
ListAttrType_visible_shift	=	2
ListAttrType_visible_count	=	1
ListAttrType_visible_mask	=	0x00000004
ListAttrType_poppedUp_shift	=	3
ListAttrType_poppedUp_count	=	1
ListAttrType_poppedUp_mask	=	0x00000008
ListAttrType_reserved_shift	=	4
ListAttrType_reserved_count	=	4
ListAttrType_reserved_mask	=	0x000000f0
ListType.id = 0
ListType.bounds.RectangleTy = 2
ListType.attr = 2
ListType.pad = 2
ListType.itemsText = 2
ListType.numItems = 6
ListType.currentItem = 8
ListType.topItem = 10
ListType.font = 12
ListType.pad2 = 12
ListType.popupWin = 12
ListType.drawItemsCallback = 16
			| UI\Menu.h
noMenuSelection	=	-1
noMenuItemSelection	=	-1
separatorItemSelection	=	-2
MenuSeparatorChar	=	'-'
MenuItemType.id = 0
MenuItemType.command = 2
MenuItemType.itemStr = 2
MenuPullDownType.menuWin = 0
MenuPullDownType.bounds.RectangleTy = 4
MenuPullDownType.bitsBehind = 4
MenuPullDownType.titleBounds.RectangleTy = 8
MenuPullDownType.title = 8
MenuPullDownType.numItems = 12
MenuPullDownType.items = 14
MenuBarAttrType_visible_shift	=	0
MenuBarAttrType_visible_count	=	1
MenuBarAttrType_visible_mask	=	0x00000001
MenuBarAttrType_commandPending_shift	=	1
MenuBarAttrType_commandPending_count	=	1
MenuBarAttrType_commandPending_mask	=	0x00000002
MenuBarAttrType_insPtEnabled_shift	=	2
MenuBarAttrType_insPtEnabled_count	=	1
MenuBarAttrType_insPtEnabled_mask	=	0x00000004
MenuBarAttrType_sizeof	=	2
MenuBarType.barWin = 0
MenuBarType.bitsBehind = 4
MenuBarType.savedActiveWin = 8
MenuBarType.bitsBehindStatus = 12
MenuBarType.attr = 16
MenuBarType.curMenu = 18
MenuBarType.curItem = 20
MenuBarType.commandTick = 22
MenuBarType.numMenus = 26
MenuBarType.menus = 28
			| UI\Progress.h
progressMaxMessage	=	128
progressMaxTitle	=	20
PrgCallbackData.stage = 0
PrgCallbackData.textP = 2
PrgCallbackData.textLen = 6
PrgCallbackData.message = 8
PrgCallbackData.error = 12
PrgCallbackData.bitmapId = 14
PrgCallbackData.flags = 16
PrgCallbackData.timeout = 18
PrgCallbackData.barMaxValue = 22
PrgCallbackData.barCurValue = 26
PrgCallbackData.barMessage = 30
PrgCallbackData.barFlags = 34
			|	canceled:1.w
			|	showDetails:1.w
			|	textChanged:1.w
			|	timedOut:1.w
ProgressType.frmP = 0
ProgressType.timeout = 4
ProgressType.flags = 8
ProgressType.error = 10
ProgressType.stage = 12
ProgressType.lastBitmapID = 14
ProgressType.ctlLabel = 16
ProgressType.serviceNameP = 24
ProgressType.lastBarMaxValue = 28
ProgressType.lastBarCurValue = 32
ProgressType.oldDrawWinH = 36
ProgressType.oldActiveWinH = 40
ProgressType.oldFrmP = 44
ProgressType.oldInsPtState = 48
ProgressType.oldInsPtPos.PointTy = 50
ProgressType.textCallback = 50
ProgressType.title. = 54
			|	needUpdate:1.w
			|	cancel:1.w
			|	waitingForOK:1.w
			|	showDetails:1.w
			|	messageChanged:1.w
			| UI\ScrDriver.h
			|
			|scrMaxLineBytes	equ	32
			|
			| ScrDisplayModeOperation
scrDisplayModeGetDefaults	=	0
scrDisplayModeGet	=	1
scrDisplayModeSetToDefaults	=	2
scrDisplayModeSet	=	3
scrDisplayModeGetSupportedDepths	=	4
scrDisplayModeGetSupportsColor	=	5
			|
			|struct ScrBltInfoType
			|	op.ScrOperation
			|	height.w
			|	dstBaseP.l
			|	dstRowBytes.l
			|	srcBaseP.l
			|	srcRowBytes.l
			|	leftMask.w
			|	rightMask.w
			|	midWords.w
			|	dstRowDelta.w
			|	dstP.l
			|	srcRowDelta.w
			|	srcP.l
			|	patternP.w
			|	solidPat.w
			|	simple.b
			|	pattern.CustomPatternType
			|endstruct
			|
			|struct ScrGlobalsType
			|	width.w
			|	height.w
			|	rowBytes.b
			|	baseAddr.l
			|	grayPat.CustomPatternType
			|	doDrawNotify.b
			|	updateR.AbsRectType
			|	lastUpdate.l
			|endstruct
			| UI\ScrDriverNew.h
scrMaxLineBytes	=	40
scrMaxDepth	=	2
			| ScrDisplayModeOperation
scrDisplayModeGetDefaults	=	0
scrDisplayModeGet	=	1
scrDisplayModeSetToDefaults	=	2
scrDisplayModeSet	=	3
scrDisplayModeGetSupportedDepths	=	4
scrDisplayModeGetSupportsColor	=	5
ScrBltInfoType.op = 0
ScrBltInfoType.height = 2
ScrBltInfoType.dstBaseP = 4
ScrBltInfoType.dstRowBytes = 8
ScrBltInfoType.dstDepth = 12
ScrBltInfoType.dstShift = 14
ScrBltInfoType.dstPixelsInWordZ = 16
ScrBltInfoType.forePixels = 18
ScrBltInfoType.backPixels = 20
ScrBltInfoType.oneBitTableP = 22
ScrBltInfoType.srcBaseP = 26
ScrBltInfoType.srcRowBytes = 30
ScrBltInfoType.srcDepth = 34
ScrBltInfoType.srcShift = 36
ScrBltInfoType.srcPixelsInWordZ = 38
ScrBltInfoType.convSrcP = 40
ScrBltInfoType.dynConvSrcP = 44
ScrBltInfoType.patternP = 46
ScrBltInfoType.simple = 50
ScrBltInfoType.dstP = 52
ScrBltInfoType.dstRowDelta = 56
ScrBltInfoType.leftMask = 60
ScrBltInfoType.rightMask = 62
ScrBltInfoType.midWords = 64
ScrBltInfoType.srcP = 66
ScrBltInfoType.srcRowDelta = 70
ScrBltInfoType.forward = 74
ScrBltInfoType.srcBytesInLine = 76
			|struct ScrGlobalsType
			|	gDevice.GDeviceType
			|	grayPat.8	;CustomPatternType
			|	doDrawNotify.w
			|	updateR.AbsRectType
			|	lastUpdate.l
			|	expSrcSize.w
			|	expSrcP.l
			|endstruct
			| UI\ScrollBar.h
			| ScrollBarRegionType
sclUpArrow	=	0
sclDownArrow	=	1
sclUpPage	=	2
sclDownPage	=	3
sclCar	=	4
ScrollBarAttrType_usable	=	0x0001
ScrollBarAttrType_visible	=	0x0002
ScrollBarAttrType_hilighted	=	0x0004
ScrollBarAttrType_shown	=	0x0008
ScrollBarAttrType_activeRegion	=	0x000F
ScrollBarType.bounds.RectangleTy = 0
ScrollBarType.id = 0
ScrollBarType.attr = 2
ScrollBarType.value = 4
ScrollBarType.minValue = 6
ScrollBarType.maxValue = 8
ScrollBarType.pageSize = 10
ScrollBarType.penPosInCar = 12
ScrollBarType.savePos = 14
			| UI\SelDay.h
daySelectorMinYear	=	firstYear
daySelectorMaxYear	=	lastYear
			| UI\SelTime.h
NumericSpaceChar	=	0x80
HMSTime.hours = 0
HMSTime.minutes = 0
HMSTime.seconds = 0
HMSTime.pad = 0
			| UI\Table.h
tableDefaultColumnSpacing	=	1
tableNoteIndicatorWidth	=	7
tableNoteIndicatorHeight	=	11
tableMaxTextItemSize	=	255
			| tableItemStyles
checkboxTableItem	=	0
customTableItem	=	1
dateTableItem	=	2
labelTableItem	=	3
numericTableItem	=	4
popupTriggerTableItem	=	5
textTableItem	=	6
textWithNoteTableItem	=	7
timeTableItem	=	8
narrowTextTableItem	=	9
TableItemType.itemType = 0
TableItemType.fontID = 0
TableItemType.intValue = 0
TableItemType.ptr = 2
TableColumnAttrType.width = 0
TableColumnAttrType.unused = 2
TableColumnAttrType.editIndicator = 4
TableColumnAttrType.usable = 6
TableColumnAttrType.spacing = 8
TableColumnAttrType.drawCallback = 10
TableColumnAttrType.loadDataCallback = 14
TableColumnAttrType.saveDataCallback = 18
TableRowAttrType.id = 0
TableRowAttrType.height = 2
TableRowAttrType.data = 4
TableRowAttrType.reserved1 = 8
TableRowAttrType.usable = 10
TableRowAttrType.reserved2 = 12
TableRowAttrType.invalid = 14
TableRowAttrType.staticHeight = 16
TableRowAttrType.selectable = 18
TableRowAttrType.reserved3 = 20
TableAttrType_visible_shift	=	0
TableAttrType_visible_count	=	1
TableAttrType_visible_mask	=	0x00000001
TableAttrType_editable_shift	=	1
TableAttrType_editable_count	=	1
TableAttrType_editable_mask	=	0x00000002
TableAttrType_editing_shift	=	2
TableAttrType_editing_count	=	1
TableAttrType_editing_mask	=	0x00000004
TableAttrType_selected_shift	=	3
TableAttrType_selected_count	=	1
TableAttrType_selected_mask	=	0x00000008
TableAttrType_hasScrollBar_shift	=	4
TableAttrType_hasScrollBar_count	=	1
TableAttrType_hasScrollBar_mask	=	0x00000010
TableType.id = 0
TableType.bounds.RectangleTy = 2
TableType.attr = 2
TableType.pad = 2
TableType.numColumns = 2
TableType.numRows = 4
TableType.currentRow = 6
TableType.currentColumn = 8
TableType.topRow = 10
TableType.columnAttrs = 12
TableType.rowAttrs = 16
TableType.items = 20
TableType.currentField.FieldTy = 24
			| UI\UICommon.h
strRsc	=	0x74535452
ainRsc	=	0x7441494e
iconType	=	0x74414942
bitmapRsc	=	0x54626d70
alertRscType	=	0x54616c74
kbdRscType	=	0x746b6264
MenuRscType	=	0x4d424152
fontRscType	=	0x4e464e54
verRsc	=	0x74766572
appInfoStringsRsc	=	0x74414953
appVersionID	=	1
appVersionAlternateID	=	1000
ainID	=	1000
defaultAppIconBitmap	=	10000
defaultAppSmallIconBitmap	=	10001
systemVersionID	=	10000
palmLogoBitmap	=	10000
keyboardBackspaceBitmap	=	10001
keyboardTabBitmap	=	10002
keyboardReturnBitmap	=	10003
InformationAlertBitmap	=	10004
ConfirmationAlertBitmap	=	10005
WarningAlertBitmap	=	10006
ErrorAlertBitmap	=	10007
keyboardShiftBitmap	=	10008
keyboardCapBitmap	=	10009
daysOfWeekStrID	=	10000
dayFullNamesStrID	=	10001
monthNamesStrID	=	10002
monthFullNamesStrID	=	10003
categoryAllStrID	=	10004
categoryEditStrID	=	10005
menuCommandStrID	=	10006
launcherBatteryStrID	=	10007
systemNameStrID	=	10008
phoneLookupTitleStrID	=	10009
phoneLookupAddStrID	=	10010
phoneLookupFormatStrID	=	10011
oemProductNameStrID	=	10012
proStrID	=	10013
demoStrID	=	10014
sysSendStatusBeamingStrID	=	10015
sysSendStatusReceivingStrID	=	10016
SelectACategoryAlert	=	10000
			| This alert broke 1.0 applications and is now disabled until later.
			| It is redefined below (10015).
			|#define RemoveCategoryAlert				10001
			|#define RemoveCategoryRecordsButton		0
			|#define RemoveCategoryNameButton			1
			|#define RemoveCategoryCancelButton		2
LowBatteryAlert	=	10002
VeryLowBatteryAlert	=	10003
UndoAlert	=	10004
UndoCancelButton	=	1
MergeCategoryAlert	=	10005
MergeCategoryYes	=	0
MergeCategoryNo	=	1
privateRecordInfoAlert	=	10006
ClipboardLimitAlert	=	10007
CategoryExistsAlert	=	10012
DeviceFullAlert	=	10013
categoryAllUsedAlert	=	10014
RemoveCategoryAlert	=	10015
RemoveCategoryYes	=	0
RemoveCategoryNo	=	1
DemoUnitAlert	=	10016
NoDataToBeamAlert	=	10017
sysEditMenuID	=	10000
sysEditMenuUndoCmd	=	10000
sysEditMenuCutCmd	=	10001
sysEditMenuCopyCmd	=	10002
sysEditMenuPasteCmd	=	10003
sysEditMenuSelectAllCmd	=	10004
sysEditMenuSeparator	=	10005
sysEditMenuKeyboardCmd	=	10006
sysEditMenuGraffitiCmd	=	10007
sysKeyboardMenuID	=	10100
sysKeyboardEditUndoCmd	=	100
sysKeyboardEditCutCmd	=	101
sysKeyboardEditCopyCmd	=	102
sysKeyboardEditPasteCmd	=	103
sysKeyboardEditSelectAllCmd	=	104
noteMenuID	=	10200
noteUndoCmd	=	10000
noteCutCmd	=	10001
noteCopyCmd	=	10002
notePasteCmd	=	10003
noteSelectAllCmd	=	10004
noteSeparator	=	10005
noteKeyboardCmd	=	10006
noteGraffitiCmd	=	10007
noteFontCmd	=	10200
noteTopOfPageCmd	=	10201
noteBottomOfPageCmd	=	10202
notePhoneLookupCmd	=	10203
SystemKeyboardID	=	10000
CategoriesEditForm	=	10000
CategoriesEditList	=	10002
CategoriesEditOKButton	=	10003
CategoriesEditNewButton	=	10004
CategoriesEditRenameButton	=	10005
CategoriesEditDeleteButton	=	10006
DateSelectorForm	=	10100
DateSelectorYearLabel	=	10102
DateSelectorPriorYearButton	=	10103
DateSelectorNextYearButton	=	10104
DateSelectorTodayButton	=	10118
DateSelectorCancelButton	=	10119
DateSelectorDayGadget	=	10120
DateSelectorThisWeekButton	=	10121
DateSelectorThisMonthButton	=	10122
TimeSelectorForm	=	10200
TimeSelectorStartTimeButton	=	10204
TimeSelectorEndTimeButton	=	10205
TimeSelectorHourList	=	10206
TimeSelectorMinuteList	=	10207
TimeSelectorOKButton	=	10208
TimeSelectorCancelButton	=	10209
TimeSelectorNoTimeButton	=	10210
KeyboardForm	=	10300
KeyboardGadget	=	10310
HelpForm	=	10400
HelpField	=	10402
HelpDoneButton	=	10403
HelpUpButton	=	10404
HelpDownButton	=	10405
FindDialog	=	10500
FindStrField	=	10503
FindOKButton	=	10504
FindResultsDialog	=	10600
FindResultsMsgLabel	=	10602
FindResultsTable	=	10603
FindResultsGoToButton	=	10604
FindResultsCancelButton	=	10605
FindResultsMoreButton	=	10606
FindResultsStopButton	=	10607
FindResultsSearchingStr	=	10607
FindResultsMatchesStr	=	10608
FindResultsNoMatchesStr	=	10609
FindResultsContinueStr	=	10610
NoteView	=	10900
NoteField	=	10901
NoteDoneButton	=	10902
NoteSmallFontButton	=	10903
NoteLargeFontButton	=	10904
NoteDeleteButton	=	10905
NoteUpButton	=	10906
NoteDownButton	=	10907
NoteScrollBar	=	10908
NoteFontGroup	=	1
noteViewMaxLength	=	4096
aboutDialog	=	11000
aboutNameLabel	=	11001
aboutVersionLabel	=	11002
aboutErrorStr	=	11003
categoryNewNameDialog	=	11100
categoryNewNameField	=	11103
categoryNewNameOKButton	=	11104
graffitiReferenceDialog	=	11200
graffitiReferenceDoneButton	=	11202
graffitiReferenceUpButton	=	11203
graffitiReferenceDownButton	=	11204
graffitiReferenceFirstBitmap	=	11205
netSerStringList	=	11300
netSerProgressFrm	=	11300
netSerProgressLabelStage	=	11302
netSerProgressBtnCancel	=	11303
netSerPictPhone	=	11300
netSerPictHandshake	=	11301
netSerPictBook	=	11302
netSerPromptFrm	=	11400
netSerPromptAsk	=	11402
netSerPromptField	=	11403
netSerPromptBtnOK	=	11404
netSerPromptBtnCancel	=	11405
launcherDialog	=	11500
launcherGadget	=	11501
prgStringList	=	11600
prgProgressFrm	=	11600
prgProgressLabelStage	=	11602
prgProgressBtnCancel	=	11603
prgPictPhone	=	11620
prgPictHandshake	=	11621
prgPictBook	=	11622
prgPictError	=	11623
prgBeamSend1	=	11640
prgBeamSend2	=	11641
prgBeamRec1	=	11642
prgBeamRec2	=	11643
prgBeamPrepare1	=	11644
prgBeamPrepare2	=	11645
prgBeamIdle	=	11646
exgPrgStringList	=	11650
exgStrIndexOK	=	1
exgStrIndexCancelling	=	2
exgStrIndexError	=	3
exgStrIndexInitializing	=	4
exgStrIndexStarting	=	5
exgStrIndexSearching	=	6
exgStrIndexConnected	=	7
exgStrIndexSending	=	8
exgStrIndexReceiving	=	9
exgStrIndexDisconnecting	=	10
exgStrIndexWaitingSender	=	11
exgStrIndexPreparing	=	12
exgStrIndexAccepting	=	13
exgStrIndexInterrupted	=	14
ExchangeForm	=	11700
ExchangeOKButton	=	11701
ExchangeCancelButton	=	11702
ExchangeIconBitMap	=	11704
ExchangeMessageField	=	11703
ExchangeQuestionString	=	11710
ExchangeUnnamedString	=	11711
ExchangeIrBeamString	=	11712
ExchangeLowBatteryAlert	=	11720
ExchangeReceiveDisabledAlert	=	11730
ExchangeIrUnsupportedAlert	=	11740
ExchangeNoLibraryAlert	=	11750
FontSelectorForm	=	11900
FontSelector1Button	=	11903
FontSelector2Button	=	11904
FontSelector3Button	=	11905
FontSelectorOKButton	=	11906
FontSelectorCancelButton	=	11907
FontSelectorFontGroup	=	1
CustomAlertDialog	=	12000
CustomAlertBitmap	=	12002
CustomAlertField	=	12003
CustomAlertFirstButton	=	12004
			| UI\UIGlobals.h
UIDefNumSysFonts	=	8
UIDefNumAppFonts	=	4
eventQueueSize	=	10
UIGlobalsType.activeWindow = 0
UIGlobalsType.displayWindow = 4
UIGlobalsType.drawWindow = 8
UIGlobalsType.firstWindow = 12
UIGlobalsType.exitWindowID = 16
UIGlobalsType.enterWindowID = 20
UIGlobalsType.exitedWindowID = 24
UIGlobalsType.gState.GraphicStateTy = 28
UIGlobalsType.eventQ = 28
UIGlobalsType.eventQIndex = 32
UIGlobalsType.eventQLength = 34
UIGlobalsType.lastScreenX = 36
UIGlobalsType.lastScreenY = 38
UIGlobalsType.lastPenDown = 40
UIGlobalsType.Pad = 40
UIGlobalsType.needNullTickCount = 40
UIGlobalsType.uiCurrentFontPtr = 44
UIGlobalsType.FontPtr = 48
UIGlobalsType.uiSysFontTablePtr = 52
UIGlobalsType.uiAppFontTablePtr = 56
UIGlobalsType.uiNumSysFonts = 60
UIGlobalsType.uiNumAppFonts = 62
UIGlobalsType.uiUnused1 = 64
UIGlobalsType.uiUnused2 = 68
UIGlobalsType.uiCurrentFontID = 72
UIGlobalsType.pad2 = 72
UIGlobalsType.currentForm = 72
UIGlobalsType.insPtIsEnabled = 76
UIGlobalsType.insPtOn = 76
UIGlobalsType.insPtLoc.PointTy = 76
UIGlobalsType.insPtHeight = 76
UIGlobalsType.insPtLastTick = 78
UIGlobalsType.insPtBitsBehind = 82
UIGlobalsType.clipboard. = 86
UIGlobalsType.uiCurrentMenu = 86
UIGlobalsType.uiCurrentMenuRscID = 90
UIGlobalsType.undoGlobals.FieldUndoTy = 92
UIGlobalsType.gsiState = 92
UIGlobalsType.gsiIsEnabled = 92
UIGlobalsType.gsiLocation.PointTy = 92
UIGlobalsType.uiDecimalSeparator = 92
			| Custom code here
			| Custom Library calls for the Pacific MicroInstrument PMI-12 ADC Springboard
			| defined in PmiLib1.h (changed PmiLibTrap to sysLibTrap for Jump)
			| added by Rod Montrose 11/02/01
			|
			| standard Library functions
sysLibTrapPMIOpen	=	sysLibTrapOpen
sysLibTrapPMIOpenCallBack	=	sysLibTrapOpen
sysLibTrapPMIOpenCallBack2	=	sysLibTrapOpen
sysLibTrapPMIClose	=	sysLibTrapClose
sysLibTrapPMISleep	=	sysLibTrapSleep
sysLibTrapPMIWake	=	sysLibTrapWake
			| custom API Library functions here
sysLibTrapPMIGetLibAPIVersion	=	sysLibTrapCustom
sysLibTrapPMIPowerADC	=	sysLibTrapCustom+1
sysLibTrapPMIGetFirmwareVersion	=	sysLibTrapCustom+2
sysLibTrapPMIStartADC	=	sysLibTrapCustom+3
sysLibTrapPMIStopADC	=	sysLibTrapCustom+4
sysLibTrapPMIGet	=	sysLibTrapCustom+5
sysLibTrapPMISet	=	sysLibTrapCustom+6
sysLibTrapPMIReadBuffer	=	sysLibTrapCustom+7
sysLibTrapPMIReadBufferByteArray	=	sysLibTrapCustom+7
sysLibTrapPMIReadStreamFile	=	sysLibTrapCustom+8
sysLibTrapPMIReadStreamFileByteArray	=	sysLibTrapCustom+8
sysLibTrapPMIReadTriggerFile	=	sysLibTrapCustom+9
sysLibTrapPMIReadTriggerFileByteArray	=	sysLibTrapCustom+9
sysLibTrapPMIReadFile	=	sysLibTrapCustom+10
sysLibTrapPMISaveFile	=	sysLibTrapCustom+11
			| Custom Library calls for the Symbol ScanMgr library.
			| added by Rod Montrose 11/09/02. Based on GCC ScanMgrLib.h file
			| from john@acaciacons.com.au
			|
sysLibTrapScanMgrLibOpen	=	sysLibTrapOpen
sysLibTrapScanMgrLibClose	=	sysLibTrapClose
sysLibTrapScanMgrLibSleep	=	sysLibTrapSleep
sysLibTrapScanMgrLibWake	=	sysLibTrapWake
			| custom API Library functions here
sysLibTrapScanMgrLibGetLibAPIVersion	=	sysLibTrapCustom	| $A805
sysLibTrapScanKernGetDecodedData	=	sysLibTrapCustom+1	| $A806
sysLibTrapScanKernCommandSend	=	sysLibTrapCustom+2	| $A807
sysLibTrapScanKernSendParams	=	sysLibTrapCustom+3	| $A808
sysLibTrapScanKernParamPacket	=	sysLibTrapCustom+4	| $A809
sysLibTrapScanSetBarcodeEnable	=	sysLibTrapCustom+4	| $A809
sysLibTrapScanSetTriggeringModes	=	sysLibTrapCustom+4	| $A809
sysLibTrapScanGetExtendedDecodedData	=	sysLibTrapCustom+4	| $A809
sysLibTrapScanKernParamRequest	=	sysLibTrapCustom+5	| $A80A
sysLibTrapScanGetBarcodeEnabled	=	sysLibTrapCustom+5	| $A80A
sysLibTrapScanKernParamRequestMultiple	=	sysLibTrapCustom+6	| $A80B
sysLibTrapScanKernGetParam	=	sysLibTrapCustom+7	| $A80C
sysLibTrapScanKernParamBatchIsRoom	=	sysLibTrapCustom+8	| $A80D
sysLibTrapScanKernGetAllParams	=	sysLibTrapCustom+9	| $A80E
sysLibTrapScanKernCmdLED	=	sysLibTrapCustom+10	| $A80F
sysLibTrapScanKernBeep	=	sysLibTrapCustom+11	| $A810
sysLibTrapScanKernSetBeepParams	=	sysLibTrapCustom+12	| $A811
sysLibTrapScanKernGetBeepParams	=	sysLibTrapCustom+13	| $A812
sysLibTrapScanKernDecInitDecoder	=	sysLibTrapCustom+14	| $A813
sysLibTrapScanKernDecKillDecoder	=	sysLibTrapCustom+15	| $A814
sysLibTrapScanKernSetLocalParam	=	sysLibTrapCustom+16	| $A815
sysLibTrapScanKernGetLocalParam	=	sysLibTrapCustom+17	| $A816
sysLibTrapScanKernGetVersionString	=	sysLibTrapCustom+18	| $A817
sysLibTrapScanGetPrefixSuffixValue	=	sysLibTrapCustom+18	| $A818
			| from HostControl.h
			| Host information selectors
hostSelectorGetHostVersion	=	0x0100
hostSelectorGetHostID	=	0x0101
hostSelectorGetHostPlatform	=	0x0102
hostSelectorIsSelectorImplemented	=	0x0103
hostSelectorGestalt	=	0x0104
hostSelectorIsCallingTrap	=	0x0105
			| Profiler selectors
hostSelectorProfileInit	=	0x0200
hostSelectorProfileStart	=	0x0201
hostSelectorProfileStop	=	0x0202
hostSelectorProfileDump	=	0x0203
hostSelectorProfileCleanup	=	0x0204
hostSelectorProfileDetailFn	=	0x0205
			| Std C Library wrapper selectors
hostSelectorErrNo	=	0x0300
hostSelectorFClose	=	0x0301
hostSelectorFEOF	=	0x0302
hostSelectorFError	=	0x0303
hostSelectorFFlush	=	0x0304
hostSelectorFGetC	=	0x0305
hostSelectorFGetPos	=	0x0306
hostSelectorFGetS	=	0x0307
hostSelectorFOpen	=	0x0308
hostSelectorFPrintF	=	0x0309/*FloatingpointnotyetsupportedinPoser*/
hostSelectorFPutC	=	0x030A
hostSelectorFPutS	=	0x030B
hostSelectorFRead	=	0x030C
hostSelectorRemove	=	0x030D
hostSelectorRename	=	0x030E
hostSelectorFReopen	=	0x030F/*NotyetimplementedinPoser*/
hostSelectorFScanF	=	0x0310/*Notyetimplemented*/
hostSelectorFSeek	=	0x0311
hostSelectorFSetPos	=	0x0312
hostSelectorFTell	=	0x0313
hostSelectorFWrite	=	0x0314
hostSelectorTmpFile	=	0x0315
hostSelectorTmpNam	=	0x0316
hostSelectorGetEnv	=	0x0317
hostSelectorMalloc	=	0x0318
hostSelectorRealloc	=	0x0319
hostSelectorFree	=	0x031A
			| time.h wrappers
hostSelectorAscTime	=	0x0370
hostSelectorClock	=	0x0371
hostSelectorCTime	=	0x0372
hostSelectorGMTime	=	0x0374
hostSelectorLocalTime	=	0x0375
hostSelectorMkTime	=	0x0376
hostSelectorStrFTime	=	0x0377
hostSelectorTime	=	0x0378
			| dirent.h wrappers
hostSelectorOpenDir	=	0x0380
hostSelectorReadDir	=	0x0381
hostSelectorCloseDir	=	0x0383
			| fcntl.h wrappers
			| unistd.h wrappers
hostSelectorRmDir	=	0x0394
hostSelectorTruncate	=	0x03A7
			| sys/stat.h wrappers
hostSelectorMkDir	=	0x03AA
hostSelectorStat	=	0x03AB
			| sys/time.h wrappers
hostSelectorUTime	=	0x03AE
			| DOS attr 
hostSelectorGetFileAttr	=	0x03AF
hostSelectorSetFileAttr	=	0x03B0
			| Gremlin selectors
hostSelectorGremlinIsRunning	=	0x0400
hostSelectorGremlinNumber	=	0x0401
hostSelectorGremlinCounter	=	0x0402
hostSelectorGremlinLimit	=	0x0403
hostSelectorGremlinNew	=	0x0404
			| Database selectors
hostSelectorImportFile	=	0x0500
hostSelectorExportFile	=	0x0501
hostSelectorExgLibOpen	=	0x0580
hostSelectorExgLibClose	=	0x0581
hostSelectorExgLibSleep	=	0x0582
hostSelectorExgLibWake	=	0x0583
hostSelectorExgLibHandleEvent	=	0x0584
hostSelectorExgLibConnect	=	0x0585
hostSelectorExgLibAccept	=	0x0586
hostSelectorExgLibDisconnect	=	0x0587
hostSelectorExgLibPut	=	0x0588
hostSelectorExgLibGet	=	0x0589
hostSelectorExgLibSend	=	0x058A
hostSelectorExgLibReceive	=	0x058B
hostSelectorExgLibControl	=	0x058C
hostSelectorExgLibRequest	=	0x058D
			| Preferences selectors
hostSelectorGetPreference	=	0x0600
hostSelectorSetPreference	=	0x0601
			| Logging selectors
hostSelectorLogFile	=	0x0700
hostSelectorSetLogFileSize	=	0x0701
			| RPC selectors
hostSelectorSessionCreate	=	0x0800/*NotyetimplementedinPoser*/
hostSelectorSessionOpen	=	0x0801/*NotyetimplementedinPoser*/
hostSelectorSessionClose	=	0x0802
hostSelectorSessionQuit	=	0x0803
hostSelectorSignalSend	=	0x0804
hostSelectorSignalWait	=	0x0805
hostSelectorSignalResume	=	0x0806
			| External tracing tool support
hostSelectorTraceInit	=	0x0900
hostSelectorTraceClose	=	0x0901
hostSelectorTraceOutputT	=	0x0902
hostSelectorTraceOutputTL	=	0x0903
hostSelectorTraceOutputVT	=	0x0904
hostSelectorTraceOutputVTL	=	0x0905
hostSelectorTraceOutputB	=	0x0906
			| File choosing support
hostSelectorGetFile	=	0x0B00
hostSelectorPutFile	=	0x0B01
hostSelectorGetDirectory	=	0x0B02
hostSelectorLastTrapNumber	=	0x0BFF
			| from ExpansionMgr.c
expInit	=	0
expSlotDriverInstall	=	1
expSlotDriverRemove	=	2
expSlotLibFind	=	3
expSlotRegister	=	4
expSlotUnregister	=	5
expCardInserted	=	6
expCardRemoved	=	7
expCardPresent	=	8
expCardInfo	=	9
expSlotEnumerate	=	10
expCardGetSerialPort	=	11
	.list
