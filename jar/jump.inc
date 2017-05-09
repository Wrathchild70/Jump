	list 0		;disable listing

;--------------------------------------------------------------------------
; jump.inc
;
;--------------------------------------------------------------------------

; System\SystemMgr.rh


sysFileCSystem		equ	'psys'
sysFileCGraffiti	equ	'graf'
sysFileCSystemPatch	equ	'ptch'

sysFileCCalculator	equ	'calc'
sysFileCSecurity	equ	'secr'
sysFileCPreferences	equ	'pref'
sysFileCAddress		equ	'addr'
sysFileCToDo		equ	'todo'
sysFileCDatebook	equ	'date'
sysFileCMemo		equ	'memo'
sysFileCSync		equ	'sync'
sysFileCMemory		equ	'memr'
sysFileCMail		equ	'mail'
sysFileCExpense		equ	'exps'
sysFileCLauncher	equ	'lnch'

sysFileCGraffitiDemo	equ	'gdem'
sysFileCMailDemo	equ	'mdem'

sysFileCFirstApp		equ	sysFileCPreferences
sysFileCDefaultApp		equ	sysFileCPreferences
sysFileCDefaultButton1App	equ	sysFileCDatebook
sysFileCDefaultButton2App	equ	sysFileCAddress
sysFileCDefaultButton3App	equ	sysFileCToDo
sysFileCDefaultButton4App	equ	sysFileCMemo
sysFileCDefaultCalcButtonApp	equ	sysFileCCalculator
sysFileCDefaultCradleApp	equ	sysFileCSync
sysFileCDefaultModemApp		equ	sysFileCSync
sysFileCNullApp			equ	'0000'

sysFileCDigitizer	equ	'digi'
sysFileCGeneral		equ	'gnrl'
sysFileCFormats		equ	'frmt'
sysFileCShortCuts	equ	'shct'
sysFileCButtons		equ	'bttn'
sysFileCOwner		equ	'ownr'
sysFileCModemPanel	equ	'modm'
sysFileCDialPanel	equ	'dial'
sysFileCNetworkPanel	equ	'netw'
sysFileCPADHtal		equ	'hpad'
sysFileCTCPHtal		equ	'htcp'
sysFileCMineHunt	equ	'mine'
sysFileCPuzzle15	equ	'puzl'
sysFileCOpenLibInfo	equ	'olbi'

sysFileTLibrary		equ	'libr'

sysFileCNet		equ	'netl'
sysFileCIrLib		equ	'irda'

sysFileCSerialHwrMgr	equ	'shwm'
sysFileCSerialWrapper	equ	'swrp'
sysFileCIrSerialWrapper	equ	'iwrp'

sysFileTUartPlugIn	equ	'sdrv'
sysFileCUart328		equ	'u328'
sysFileCUart650		equ	'u650'

sysFileTSystem		equ	'rsrc'
sysFileTSystemPatch	equ	'ptch'
sysFileTKernel		equ	'krnl'
sysFileTUIAppShell	equ	'uish'
sysFileTExtension	equ	'extn'
sysFileTApplication	equ	'appl'
sysFileTPanel		equ	'panl'
sysFileTSavedPreferences	equ	'sprf'
sysFileTPreferences	equ	'pref'
sysFileTMidi		equ	'smfr'

sysFileTGraffitiMacros	equ	'macr'

sysFileTHtalLib		equ	'htal'

sysFileTExgLib		equ	'exgl'

sysFileTFileStream	equ	'strm'

sysFileTTemp		equ	'temp'

sysResTBootCode		equ	'boot'
sysResIDBootReset	equ	10000
sysResIDBootInitCode	equ	10001
sysResIDBootSysCodeStart	equ	10100
sysResIDBootSysCodeMin	equ	10102
sysResIDBootUICodeStart	equ	10200
sysResIDBootUICodeMin	equ	10203

sysResTAppPrefs		equ	'pref'

sysResTAppCode		equ	'code'
sysResTAppGData		equ	'data'

sysResTExtensionCode	equ	'extn'

sysResTFeatures		equ	'feat'
sysResIDFeatures	equ	10000

sysResTCountries	equ	'cnty'
sysResIDCountries	equ	10000

sysResTLibrary			equ	'libr'
sysResIDLibrarySerMgr328	equ	10000
sysResIDLibrarySerMgr681	equ	10001
sysResIDLibraryRMPPlugIn	equ	10002

sysResTGrfTemplate	equ	'tmpl'
sysResIDGrfTemplate	equ	10000
sysResTGrfDictionary	equ	'dict'
sysResIDGrfDictionary	equ	10000
sysResIDGrfDefaultMacros	equ	10000

sysResTDefaultDB	equ	'dflt'
sysResIDDefaultDB	equ	1

sysResTErrStrings	equ	'tST'
sysResIDErrStrings	equ	10000

sysResTSysPref			equ	sysFileCSystem
sysResIDSysPrefMain		equ	0
sysResIDSysPrefPassword		equ	1
sysResIDSysPrefFindStr		equ	2
sysResIDSysPrefCalibration	equ	3
sysResIDDlkUserInfo		equ	4
sysResIDDlkLocalPC		equ	5
sysResIDDlkCondFilterTab	equ	6
sysResIDModemMgrPref		equ	7
sysResIDDlkLocalPCAddr		equ	8
sysResIDDlkLocalPCMask		equ	9

sysResTInBox	equ	'ibox'
sysResTOutBox	equ	'obox'


; system/systraps.h

sysTrapBase				equ	$A000
sysTrapMemInit				equ	40960
sysTrapMemInitHeapTable			equ	40961
sysTrapMemStoreInit			equ	40962
sysTrapMemCardFormat			equ	40963
sysTrapMemCardInfo			equ	40964
sysTrapMemStoreInfo			equ	40965
sysTrapMemStoreSetInfo			equ	40966
sysTrapMemNumHeaps			equ	40967
sysTrapMemNumRAMHeaps			equ	40968
sysTrapMemHeapID			equ	40969
sysTrapMemHeapPtr			equ	40970
sysTrapMemHeapFreeBytes			equ	40971
sysTrapMemHeapSize			equ	40972
sysTrapMemHeapFlags			equ	40973
sysTrapMemHeapCompact			equ	40974
sysTrapMemHeapInit			equ	40975
sysTrapMemHeapFreeByOwnerID		equ	40976
sysTrapMemChunkNew			equ	40977
sysTrapMemChunkFree			equ	40978
sysTrapMemPtrNew			equ	40979
sysTrapMemPtrFree			equ	sysTrapMemChunkFree
sysTrapMemPtrRecoverHandle		equ	40980
sysTrapMemPtrFlags			equ	40981
sysTrapMemPtrSize			equ	40982
sysTrapMemPtrOwner			equ	40983
sysTrapMemPtrHeapID			equ	40984
sysTrapMemPtrCardNo			equ	40985
sysTrapMemPtrToLocalID			equ	40986
sysTrapMemPtrSetOwner			equ	40987
sysTrapMemPtrResize			equ	40988
sysTrapMemPtrResetLock			equ	40989
sysTrapMemHandleNew			equ	40990
sysTrapMemHandleLockCount		equ	40991
sysTrapMemHandleToLocalID		equ	40992
sysTrapMemHandleLock			equ	40993
sysTrapMemHandleUnlock			equ	40994
sysTrapMemLocalIDToGlobal		equ	40995
sysTrapMemLocalIDKind			equ	40996
sysTrapMemLocalIDToPtr			equ	40997
sysTrapMemMove				equ	40998
sysTrapMemSet				equ	40999
sysTrapMemStoreSearch			equ	41000
sysTrapMemPtrDataStorage		equ	41001
sysTrapMemKernelInit			equ	41002
sysTrapMemHandleFree			equ	41003
sysTrapMemHandleFlags			equ	41004
sysTrapMemHandleSize			equ	41005
sysTrapMemHandleOwner			equ	41006
sysTrapMemHandleHeapID			equ	41007
sysTrapMemHandleDataStorage		equ	41008
sysTrapMemHandleCardNo			equ	41009
sysTrapMemHandleSetOwner		equ	41010
sysTrapMemHandleResize			equ	41011
sysTrapMemHandleResetLock		equ	41012
sysTrapMemPtrUnlock			equ	41013
sysTrapMemLocalIDToLockedPtr		equ	41014
sysTrapMemSetDebugMode			equ	41015
sysTrapMemHeapScramble			equ	41016
sysTrapMemHeapCheck			equ	41017
sysTrapMemNumCards			equ	41018
sysTrapMemDebugMode			equ	41019
sysTrapMemSemaphoreReserve		equ	41020
sysTrapMemSemaphoreRelease		equ	41021
sysTrapMemHeapDynamic			equ	41022
sysTrapMemNVParams			equ	41023

sysTrapDmInit				equ	41024
sysTrapDmCreateDatabase			equ	41025
sysTrapDmDeleteDatabase			equ	41026
sysTrapDmNumDatabases			equ	41027
sysTrapDmGetDatabase			equ	41028
sysTrapDmFindDatabase			equ	41029
sysTrapDmDatabaseInfo			equ	41030
sysTrapDmSetDatabaseInfo		equ	41031
sysTrapDmDatabaseSize			equ	41032
sysTrapDmOpenDatabase			equ	41033
sysTrapDmCloseDatabase			equ	41034
sysTrapDmNextOpenDatabase		equ	41035
sysTrapDmOpenDatabaseInfo		equ	41036
sysTrapDmResetRecordStates		equ	41037
sysTrapDmGetLastErr			equ	41038
sysTrapDmNumRecords			equ	41039
sysTrapDmRecordInfo			equ	41040
sysTrapDmSetRecordInfo			equ	41041
sysTrapDmAttachRecord			equ	41042
sysTrapDmDetachRecord			equ	41043
sysTrapDmMoveRecord			equ	41044
sysTrapDmNewRecord			equ	41045
sysTrapDmRemoveRecord			equ	41046
sysTrapDmDeleteRecord			equ	41047
sysTrapDmArchiveRecord			equ	41048
sysTrapDmNewHandle			equ	41049
sysTrapDmRemoveSecretRecords		equ	41050
sysTrapDmQueryRecord			equ	41051
sysTrapDmGetRecord			equ	41052
sysTrapDmResizeRecord			equ	41053
sysTrapDmReleaseRecord			equ	41054
sysTrapDmGetResource			equ	41055
sysTrapDmGet1Resource			equ	41056
sysTrapDmReleaseResource		equ	41057
sysTrapDmResizeResource			equ	41058
sysTrapDmNextOpenResDatabase		equ	41059
sysTrapDmFindResourceType		equ	41060
sysTrapDmFindResource			equ	41061
sysTrapDmSearchResource			equ	41062
sysTrapDmNumResources			equ	41063
sysTrapDmResourceInfo			equ	41064
sysTrapDmSetResourceInfo		equ	41065
sysTrapDmAttachResource			equ	41066
sysTrapDmDetachResource			equ	41067
sysTrapDmNewResource			equ	41068
sysTrapDmRemoveResource			equ	41069
sysTrapDmGetResourceIndex		equ	41070
sysTrapDmQuickSort			equ	41071
sysTrapDmQueryNextInCategory		equ	41072
sysTrapDmNumRecordsInCategory		equ	41073
sysTrapDmPositionInCategory		equ	41074
sysTrapDmSeekRecordInCategory		equ	41075
sysTrapDmMoveCategory			equ	41076
sysTrapDmOpenDatabaseByTypeCreator	equ	41077
sysTrapDmWrite				equ	41078
sysTrapDmStrCopy			equ	41079
sysTrapDmGetNextDatabaseByTypeCreator	equ	41080
sysTrapDmWriteCheck			equ	41081
sysTrapDmMoveOpenDBContext		equ	41082
sysTrapDmFindRecordByID			equ	41083
sysTrapDmGetAppInfoID			equ	41084
sysTrapDmFindSortPositionV10		equ	41085
sysTrapDmSet				equ	41086
sysTrapDmCreateDatabaseFromImage	equ	41087

sysTrapDbgSrcMessage			equ	41088
sysTrapDbgMessage			equ	41089
sysTrapDbgGetMessage			equ	41090
sysTrapDbgCommSettings			equ	41091

sysTrapErrDisplayFileLineMsg		equ	41092
sysTrapErrSetJump			equ	41093
sysTrapErrLongJump			equ	41094
sysTrapErrThrow				equ	41095
sysTrapErrExceptionList			equ	41096

sysTrapSysBroadcastActionCode		equ	41097
sysTrapSysUnimplemented			equ	41098
sysTrapSysColdBoot			equ	41099
sysTrapSysReset				equ	41100
sysTrapSysDoze				equ	41101
sysTrapSysAppLaunch			equ	41102
sysTrapSysAppStartup			equ	41103
sysTrapSysAppExit			equ	41104
sysTrapSysSetA5				equ	41105
sysTrapSysSetTrapAddress		equ	41106
sysTrapSysGetTrapAddress		equ	41107
sysTrapSysTranslateKernelErr		equ	41108
sysTrapSysSemaphoreCreate		equ	41109
sysTrapSysSemaphoreDelete		equ	41110
sysTrapSysSemaphoreWait			equ	41111
sysTrapSysSemaphoreSignal		equ	41112
sysTrapSysTimerCreate			equ	41113
sysTrapSysTimerWrite			equ	41114
sysTrapSysTaskCreate			equ	41115
sysTrapSysTaskDelete			equ	41116
sysTrapSysTaskTrigger			equ	41117
sysTrapSysTaskID			equ	41118
sysTrapSysTaskUserInfoPtr		equ	41119
sysTrapSysTaskDelay			equ	41120
sysTrapSysTaskSetTermProc		equ	41121
sysTrapSysUILaunch			equ	41122
sysTrapSysNewOwnerID			equ	41123
sysTrapSysSemaphoreSet			equ	41124
sysTrapSysDisableInts			equ	41125
sysTrapSysRestoreStatus			equ	41126
sysTrapSysUIAppSwitch			equ	41127
sysTrapSysCurAppInfoPV20		equ	41128
sysTrapSysHandleEvent			equ	41129
sysTrapSysInit				equ	41130
sysTrapSysQSort				equ	41131
sysTrapSysCurAppDatabase		equ	41132
sysTrapSysFatalAlert			equ	41133
sysTrapSysResSemaphoreCreate		equ	41134
sysTrapSysResSemaphoreDelete		equ	41135
sysTrapSysResSemaphoreReserve		equ	41136
sysTrapSysResSemaphoreRelease		equ	41137
sysTrapSysSleep				equ	41138
sysTrapSysKeyboardDialogV10		equ	41139
sysTrapSysAppLauncherDialog		equ	41140
sysTrapSysSetPerformance		equ	41141
sysTrapSysBatteryInfoV20		equ	41142
sysTrapSysLibInstall			equ	41143
sysTrapSysLibRemove			equ	41144
sysTrapSysLibTblEntry			equ	41145
sysTrapSysLibFind			equ	41146
sysTrapSysBatteryDialog			equ	41147
sysTrapSysCopyStringResource		equ	41148
sysTrapSysKernelInfo			equ	41149
sysTrapSysLaunchConsole			equ	41150
sysTrapSysTimerDelete			equ	41151
sysTrapSysSetAutoOffTime		equ	41152
sysTrapSysFormPointerArrayToStrings	equ	41153
sysTrapSysRandom			equ	41154
sysTrapSysTaskSwitching			equ	41155
sysTrapSysTimerRead			equ	41156

sysTrapStrCopy				equ	41157
sysTrapStrCat				equ	41158
sysTrapStrLen				equ	41159
sysTrapStrCompare			equ	41160
sysTrapStrIToA				equ	41161
sysTrapStrCaselessCompare		equ	41162
sysTrapStrIToH				equ	41163
sysTrapStrChr				equ	41164
sysTrapStrStr				equ	41165
sysTrapStrAToI				equ	41166
sysTrapStrToLower			equ	41167

sysTrapSerReceiveISP			equ	41168

sysTrapSlkOpen				equ	41169
sysTrapSlkClose				equ	41170
sysTrapSlkOpenSocket			equ	41171
sysTrapSlkCloseSocket			equ	41172
sysTrapSlkSocketRefNum			equ	41173
sysTrapSlkSocketSetTimeout		equ	41174
sysTrapSlkFlushSocket			equ	41175
sysTrapSlkSetSocketListener		equ	41176
sysTrapSlkSendPacket			equ	41177
sysTrapSlkReceivePacket			equ	41178
sysTrapSlkSysPktDefaultResponse		equ	41179
sysTrapSlkProcessRPC			equ	41180

sysTrapConPutS				equ	41181
sysTrapConGetS				equ	41182

sysTrapFplInit				equ	41183
sysTrapFplFree				equ	41184
sysTrapFplFToA				equ	41185
sysTrapFplAToF				equ	41186
sysTrapFplBase10Info			equ	41187
sysTrapFplLongToFloat			equ	41188
sysTrapFplFloatToLong			equ	41189
sysTrapFplFloatToULong			equ	41190
sysTrapFplMul				equ	41191
sysTrapFplAdd				equ	41192
sysTrapFplSub				equ	41193
sysTrapFplDiv				equ	41194

sysTrapScrInit				equ	41195
sysTrapScrCopyRectangle			equ	41196
sysTrapScrDrawChars			equ	41197
sysTrapScrLineRoutine			equ	41198
sysTrapScrRectangleRoutine		equ	41199
sysTrapScrScreenInfo			equ	41200
sysTrapScrDrawNotify			equ	41201
sysTrapScrSendUpdateArea		equ	41202
sysTrapScrCompressScanLine		equ	41203
sysTrapScrDeCompressScanLine		equ	41204

sysTrapTimGetSeconds			equ	41205
sysTrapTimSetSeconds			equ	41206
sysTrapTimGetTicks			equ	41207
sysTrapTimInit				equ	41208
sysTrapTimSetAlarm			equ	41209
sysTrapTimGetAlarm			equ	41210
sysTrapTimHandleInterrupt		equ	41211
sysTrapTimSecondsToDateTime		equ	41212
sysTrapTimDateTimeToSeconds		equ	41213
sysTrapTimAdjust			equ	41214
sysTrapTimSleep				equ	41215
sysTrapTimWake				equ	41216

sysTrapCategoryCreateListV10		equ	41217
sysTrapCategoryFreeListV10		equ	41218
sysTrapCategoryFind			equ	41219
sysTrapCategoryGetName			equ	41220
sysTrapCategoryEditV10			equ	41221
sysTrapCategorySelectV10		equ	41222
sysTrapCategoryGetNext			equ	41223
sysTrapCategorySetTriggerLabel		equ	41224
sysTrapCategoryTruncateName		equ	41225

sysTrapClipboardAddItem			equ	41226
sysTrapClipboardCheckIfItemExist	equ	41227
sysTrapClipboardGetItem			equ	41228

sysTrapCtlDrawControl			equ	41229
sysTrapCtlEraseControl			equ	41230
sysTrapCtlHideControl			equ	41231
sysTrapCtlShowControl			equ	41232
sysTrapCtlGetValue			equ	41233
sysTrapCtlSetValue			equ	41234
sysTrapCtlGetLabel			equ	41235
sysTrapCtlSetLabel			equ	41236
sysTrapCtlHandleEvent			equ	41237
sysTrapCtlHitControl			equ	41238
sysTrapCtlSetEnabled			equ	41239
sysTrapCtlSetUsable			equ	41240
sysTrapCtlEnabled			equ	41241

sysTrapEvtInitialize			equ	41242
sysTrapEvtAddEventToQueue		equ	41243
sysTrapEvtCopyEvent			equ	41244
sysTrapEvtGetEvent			equ	41245
sysTrapEvtGetPen			equ	41246
sysTrapEvtSysInit			equ	41247
sysTrapEvtGetSysEvent			equ	41248
sysTrapEvtProcessSoftKeyStroke		equ	41249
sysTrapEvtGetPenBtnList			equ	41250
sysTrapEvtSetPenQueuePtr		equ	41251
sysTrapEvtPenQueueSize			equ	41252
sysTrapEvtFlushPenQueue			equ	41253
sysTrapEvtEnqueuePenPoint		equ	41254
sysTrapEvtDequeuePenStrokeInfo		equ	41255
sysTrapEvtDequeuePenPoint		equ	41256
sysTrapEvtFlushNextPenStroke		equ	41257
sysTrapEvtSetKeyQueuePtr		equ	41258
sysTrapEvtKeyQueueSize			equ	41259
sysTrapEvtFlushKeyQueue			equ	41260
sysTrapEvtEnqueueKey			equ	41261
sysTrapEvtDequeueKeyEvent		equ	41262
sysTrapEvtWakeup			equ	41263
sysTrapEvtResetAutoOffTimer		equ	41264
sysTrapEvtKeyQueueEmpty			equ	41265
sysTrapEvtEnableGraffiti		equ	41266

sysTrapFldCopy				equ	41267
sysTrapFldCut				equ	41268
sysTrapFldDrawField			equ	41269
sysTrapFldEraseField			equ	41270
sysTrapFldFreeMemory			equ	41271
sysTrapFldGetBounds			equ	41272
sysTrapFldGetTextPtr			equ	41273
sysTrapFldGetSelection			equ	41274
sysTrapFldHandleEvent			equ	41275
sysTrapFldPaste				equ	41276
sysTrapFldRecalculateField		equ	41277
sysTrapFldSetBounds			equ	41278
sysTrapFldSetText			equ	41279
sysTrapFldGetFont			equ	41280
sysTrapFldSetFont			equ	41281
sysTrapFldSetSelection			equ	41282
sysTrapFldGrabFocus			equ	41283
sysTrapFldReleaseFocus			equ	41284
sysTrapFldGetInsPtPosition		equ	41285
sysTrapFldSetInsPtPosition		equ	41286
sysTrapFldSetScrollPosition		equ	41287
sysTrapFldGetScrollPosition		equ	41288
sysTrapFldGetTextHeight			equ	41289
sysTrapFldGetTextAllocatedSize		equ	41290
sysTrapFldGetTextLength			equ	41291
sysTrapFldScrollField			equ	41292
sysTrapFldScrollable			equ	41293
sysTrapFldGetVisibleLines		equ	41294
sysTrapFldGetAttributes			equ	41295
sysTrapFldSetAttributes			equ	41296
sysTrapFldSendChangeNotification	equ	41297
sysTrapFldCalcFieldHeight		equ	41298
sysTrapFldGetTextHandle			equ	41299
sysTrapFldCompactText			equ	41300
sysTrapFldDirty				equ	41301
sysTrapFldWordWrap			equ	41302
sysTrapFldSetTextAllocatedSize		equ	41303
sysTrapFldSetTextHandle			equ	41304
sysTrapFldSetTextPtr			equ	41305
sysTrapFldGetMaxChars			equ	41306
sysTrapFldSetMaxChars			equ	41307
sysTrapFldSetUsable			equ	41308
sysTrapFldInsert			equ	41309
sysTrapFldDelete			equ	41310
sysTrapFldUndo				equ	41311
sysTrapFldSetDirty			equ	41312
sysTrapFldSendHeightChangeNotification	equ	41313
sysTrapFldMakeFullyVisible		equ	41314

sysTrapFntGetFont			equ	41315
sysTrapFntSetFont			equ	41316
sysTrapFntGetFontPtr			equ	41317
sysTrapFntBaseLine			equ	41318
sysTrapFntCharHeight			equ	41319
sysTrapFntLineHeight			equ	41320
sysTrapFntAverageCharWidth		equ	41321
sysTrapFntCharWidth			equ	41322
sysTrapFntCharsWidth			equ	41323
sysTrapFntDescenderHeight		equ	41324
sysTrapFntCharsInWidth			equ	41325
sysTrapFntLineWidth			equ	41326

sysTrapFrmInitForm			equ	41327
sysTrapFrmDeleteForm			equ	41328
sysTrapFrmDrawForm			equ	41329
sysTrapFrmEraseForm			equ	41330
sysTrapFrmGetActiveForm			equ	41331
sysTrapFrmSetActiveForm			equ	41332
sysTrapFrmGetActiveFormID		equ	41333
sysTrapFrmGetUserModifiedState		equ	41334
sysTrapFrmSetNotUserModified		equ	41335
sysTrapFrmGetFocus			equ	41336
sysTrapFrmSetFocus			equ	41337
sysTrapFrmHandleEvent			equ	41338
sysTrapFrmGetFormBounds			equ	41339
sysTrapFrmGetWindowHandle		equ	41340
sysTrapFrmGetFormId			equ	41341
sysTrapFrmGetFormPtr			equ	41342
sysTrapFrmGetNumberOfObjects		equ	41343
sysTrapFrmGetObjectIndex		equ	41344
sysTrapFrmGetObjectId			equ	41345
sysTrapFrmGetObjectType			equ	41346
sysTrapFrmGetObjectPtr			equ	41347
sysTrapFrmHideObject			equ	41348
sysTrapFrmShowObject			equ	41349
sysTrapFrmGetObjectPosition		equ	41350
sysTrapFrmSetObjectPosition		equ	41351
sysTrapFrmGetControlValue		equ	41352
sysTrapFrmSetControlValue		equ	41353
sysTrapFrmGetControlGroupSelection	equ	41354
sysTrapFrmSetControlGroupSelection	equ	41355
sysTrapFrmCopyLabel			equ	41356
sysTrapFrmSetLabel			equ	41357
sysTrapFrmGetLabel			equ	41358
sysTrapFrmSetCategoryLabel		equ	41359
sysTrapFrmGetTitle			equ	41360
sysTrapFrmSetTitle			equ	41361
sysTrapFrmAlert				equ	41362
sysTrapFrmDoDialog			equ	41363
sysTrapFrmCustomAlert			equ	41364
sysTrapFrmHelp				equ	41365
sysTrapFrmUpdateScrollers		equ	41366
sysTrapFrmGetFirstForm			equ	41367
sysTrapFrmVisible			equ	41368
sysTrapFrmGetObjectBounds		equ	41369
sysTrapFrmCopyTitle			equ	41370
sysTrapFrmGotoForm			equ	41371
sysTrapFrmPopupForm			equ	41372
sysTrapFrmUpdateForm			equ	41373
sysTrapFrmReturnToForm			equ	41374
sysTrapFrmSetEventHandler		equ	41375
sysTrapFrmDispatchEvent			equ	41376
sysTrapFrmCloseAllForms			equ	41377
sysTrapFrmSaveAllForms			equ	41378
sysTrapFrmGetGadgetData			equ	41379
sysTrapFrmSetGadgetData			equ	41380
sysTrapFrmSetCategoryTrigger		equ	41381

sysTrapUIInitialize			equ	41382
sysTrapUIReset				equ	41383

sysTrapInsPtInitialize			equ	41384
sysTrapInsPtSetLocation			equ	41385
sysTrapInsPtGetLocation			equ	41386
sysTrapInsPtEnable			equ	41387
sysTrapInsPtEnabled			equ	41388
sysTrapInsPtSetHeight			equ	41389
sysTrapInsPtGetHeight			equ	41390
sysTrapInsPtCheckBlink			equ	41391

sysTrapLstSetDrawFunction		equ	41392
sysTrapLstDrawList			equ	41393
sysTrapLstEraseList			equ	41394
sysTrapLstGetSelection			equ	41395
sysTrapLstGetSelectionText		equ	41396
sysTrapLstHandleEvent			equ	41397
sysTrapLstSetHeight			equ	41398
sysTrapLstSetSelection			equ	41399
sysTrapLstSetListChoices		equ	41400
sysTrapLstMakeItemVisible		equ	41401
sysTrapLstGetNumberOfItems		equ	41402
sysTrapLstPopupList			equ	41403
sysTrapLstSetPosition			equ	41404

sysTrapMenuInit				equ	41405
sysTrapMenuDispose			equ	41406
sysTrapMenuHandleEvent			equ	41407
sysTrapMenuDrawMenu			equ	41408
sysTrapMenuEraseStatus			equ	41409
sysTrapMenuGetActiveMenu		equ	41410
sysTrapMenuSetActiveMenu		equ	41411

sysTrapRctSetRectangle			equ	41412
sysTrapRctCopyRectangle			equ	41413
sysTrapRctInsetRectangle		equ	41414
sysTrapRctOffsetRectangle		equ	41415
sysTrapRctPtInRectangle			equ	41416
sysTrapRctGetIntersection		equ	41417

sysTrapTblDrawTable			equ	41418
sysTrapTblEraseTable			equ	41419
sysTrapTblHandleEvent			equ	41420
sysTrapTblGetItemBounds			equ	41421
sysTrapTblSelectItem			equ	41422
sysTrapTblGetItemInt			equ	41423
sysTrapTblSetItemInt			equ	41424
sysTrapTblSetItemStyle			equ	41425
sysTrapTblUnhighlightSelection		equ	41426
sysTrapTblSetRowUsable			equ	41427
sysTrapTblGetNumberOfRows		equ	41428
sysTrapTblSetCustomDrawProcedure	equ	41429
sysTrapTblSetRowSelectable		equ	41430
sysTrapTblRowSelectable			equ	41431
sysTrapTblSetLoadDataProcedure		equ	41432
sysTrapTblSetSaveDataProcedure		equ	41433
sysTrapTblGetBounds			equ	41434
sysTrapTblSetRowHeight			equ	41435
sysTrapTblGetColumnWidth		equ	41436
sysTrapTblGetRowID			equ	41437
sysTrapTblSetRowID			equ	41438
sysTrapTblMarkRowInvalid		equ	41439
sysTrapTblMarkTableInvalid		equ	41440
sysTrapTblGetSelection			equ	41441
sysTrapTblInsertRow			equ	41442
sysTrapTblRemoveRow			equ	41443
sysTrapTblRowInvalid			equ	41444
sysTrapTblRedrawTable			equ	41445
sysTrapTblRowUsable			equ	41446
sysTrapTblReleaseFocus			equ	41447
sysTrapTblEditing			equ	41448
sysTrapTblGetCurrentField		equ	41449
sysTrapTblSetColumnUsable		equ	41450
sysTrapTblGetRowHeight			equ	41451
sysTrapTblSetColumnWidth		equ	41452
sysTrapTblGrabFocus			equ	41453
sysTrapTblSetItemPtr			equ	41454
sysTrapTblFindRowID			equ	41455
sysTrapTblGetLastUsableRow		equ	41456
sysTrapTblGetColumnSpacing		equ	41457
sysTrapTblFindRowData			equ	41458
sysTrapTblGetRowData			equ	41459
sysTrapTblSetRowData			equ	41460
sysTrapTblSetColumnSpacing		equ	41461
sysTrapTblSetColumnMasked	    equ 41936
sysTrapTblSetRowMasked  	    equ 41937
sysTrapTblRowMasked	            equ 41938
sysTrapTblGetNumberOfColumns	equ 42065
sysTrapTblGetTopRow	            equ 42066
sysTrapTblSetSelection	        equ 42067

sysTrapWinCreateWindow			equ	41462
sysTrapWinCreateOffscreenWindow		equ	41463
sysTrapWinDeleteWindow			equ	41464
sysTrapWinInitializeWindow		equ	41465
sysTrapWinAddWindow			equ	41466
sysTrapWinRemoveWindow			equ	41467
sysTrapWinSetActiveWindow		equ	41468
sysTrapWinSetDrawWindow			equ	41469
sysTrapWinGetDrawWindow			equ	41470
sysTrapWinGetActiveWindow		equ	41471
sysTrapWinGetDisplayWindow		equ	41472
sysTrapWinGetFirstWindow		equ	41473
sysTrapWinEnableWindow			equ	41474
sysTrapWinDisableWindow			equ	41475
sysTrapWinGetWindowFrameRect		equ	41476
sysTrapWinDrawWindowFrame		equ	41477
sysTrapWinEraseWindow			equ	41478
sysTrapWinSaveBits			equ	41479
sysTrapWinRestoreBits			equ	41480
sysTrapWinCopyRectangle			equ	41481
sysTrapWinScrollRectangle		equ	41482
sysTrapWinGetDisplayExtent		equ	41483
sysTrapWinGetWindowExtent		equ	41484
sysTrapWinDisplayToWindowPt		equ	41485
sysTrapWinWindowToDisplayPt		equ	41486
sysTrapWinGetClip			equ	41487
sysTrapWinSetClip			equ	41488
sysTrapWinResetClip			equ	41489
sysTrapWinClipRectangle			equ	41490
sysTrapWinDrawLine			equ	41491
sysTrapWinDrawGrayLine			equ	41492
sysTrapWinEraseLine			equ	41493
sysTrapWinInvertLine			equ	41494
sysTrapWinFillLine			equ	41495
sysTrapWinDrawRectangle			equ	41496
sysTrapWinEraseRectangle		equ	41497
sysTrapWinInvertRectangle		equ	41498
sysTrapWinDrawRectangleFrame		equ	41499
sysTrapWinDrawGrayRectangleFrame	equ	41500
sysTrapWinEraseRectangleFrame		equ	41501
sysTrapWinInvertRectangleFrame		equ	41502
sysTrapWinGetFramesRectangle		equ	41503
sysTrapWinDrawChars			equ	41504
sysTrapWinEraseChars			equ	41505
sysTrapWinInvertChars			equ	41506
sysTrapWinGetPattern			equ	41507
sysTrapWinSetPattern			equ	41508
sysTrapWinSetUnderlineMode		equ	41509
sysTrapWinDrawBitmap			equ	41510
sysTrapWinModal				equ	41511
sysTrapWinGetWindowBounds		equ	41512
sysTrapWinFillRectangle			equ	41513
sysTrapWinDrawInvertedChars		equ	41514
sysTrapWinGetPixel			equ	41857
sysTrapWinSetBackColor   		equ 	41881
sysTrapWinSetTextColor   		equ 	41882


sysTrapPrefOpenPreferenceDBV10		equ	41515
sysTrapPrefGetPreferences		equ	41516
sysTrapPrefSetPreferences		equ	41517
sysTrapPrefGetAppPreferencesV10		equ	41518
sysTrapPrefSetAppPreferencesV10		equ	41519

sysTrapSndInit				equ	41520
sysTrapSndSetDefaultVolume		equ	41521
sysTrapSndGetDefaultVolume		equ	41522
sysTrapSndDoCmd				equ	41523
sysTrapSndPlaySystemSound		equ	41524
sysTrapSndStreamCreate			equ		$A45B
sysTrapSndStreamDelete			equ		$A45C
sysTrapSndStreamStart			equ		$A45D
sysTrapSndStreamPause			equ		$A45E
sysTrapSndStreamStop			equ		$A45F
sysTrapSndStreamSetVolume		equ		$A460
sysTrapSndStreamGetVolume		equ		$A461
sysTrapSndPlayResource			equ		$A462
sysTrapSndStreamSetPan			equ		$A463
sysTrapSndStreamGetPan			equ		$A464


sysTrapAlmInit				equ	41525
sysTrapAlmCancelAll			equ	41526
sysTrapAlmAlarmCallback			equ	41527
sysTrapAlmSetAlarm			equ	41528
sysTrapAlmGetAlarm			equ	41529
sysTrapAlmDisplayAlarm			equ	41530
sysTrapAlmEnableNotification		equ	41531

sysTrapHwrGetRAMMapping			equ	41532
sysTrapHwrMemWritable			equ	41533
sysTrapHwrMemReadable			equ	41534
sysTrapHwrDoze				equ	41535
sysTrapHwrSleep				equ	41536
sysTrapHwrWake				equ	41537
sysTrapHwrSetSystemClock		equ	41538
sysTrapHwrSetCPUDutyCycle		equ	41539
sysTrapHwrLCDInit			equ	41540
sysTrapHwrLCDSleep			equ	41541
sysTrapHwrTimerInit			equ	41542
sysTrapHwrCursor			equ	41543
sysTrapHwrBatteryLevel			equ	41544
sysTrapHwrDelay				equ	41545
sysTrapHwrEnableDataWrites		equ	41546
sysTrapHwrDisableDataWrites		equ	41547
sysTrapHwrLCDBaseAddr			equ	41548
sysTrapHwrLCDDrawBitmap			equ	41549
sysTrapHwrTimerSleep			equ	41550
sysTrapHwrTimerWake			equ	41551
sysTrapHwrLCDWake			equ	41552
sysTrapHwrIRQ1Handler			equ	41553
sysTrapHwrIRQ2Handler			equ	41554
sysTrapHwrIRQ3Handler			equ	41555
sysTrapHwrIRQ4Handler			equ	41556
sysTrapHwrIRQ5Handler			equ	41557
sysTrapHwrIRQ6Handler			equ	41558
sysTrapHwrDockSignals			equ	41559
sysTrapHwrPluggedIn			equ	41560

sysTrapCrc16CalcBlock			equ	41561

sysTrapSelectDayV10			equ	41562
sysTrapSelectTimeV33			equ	41563
sysTrapSelectTime			equ	41926
sysTrapSelectOneTime			equ	41807

sysTrapDayDrawDaySelector		equ	41564
sysTrapDayHandleEvent			equ	41565
sysTrapDayDrawDays			equ	41566
sysTrapDayOfWeek			equ	41567
sysTrapDaysInMonth			equ	41568
sysTrapDayOfMonth			equ	41569

sysTrapDateDaysToDate			equ	41570
sysTrapDateToDays			equ	41571
sysTrapDateAdjust			equ	41572
sysTrapDateSecondsToDate		equ	41573
sysTrapDateToAscii			equ	41574
sysTrapDateToDOWDMFormat		equ	41575
sysTrapTimeToAscii			equ	41576

sysTrapFind				equ	41577
sysTrapFindStrInStr			equ	41578
sysTrapFindSaveMatch			equ	41579
sysTrapFindGetLineBounds		equ	41580
sysTrapFindDrawHeader			equ	41581

sysTrapPenOpen				equ	41582
sysTrapPenClose				equ	41583
sysTrapPenGetRawPen			equ	41584
sysTrapPenCalibrate			equ	41585
sysTrapPenRawToScreen			equ	41586
sysTrapPenScreenToRaw			equ	41587
sysTrapPenResetCalibration		equ	41588
sysTrapPenSleep				equ	41589
sysTrapPenWake				equ	41590

sysTrapResLoadForm			equ	41591
sysTrapResLoadMenu			equ	41592

sysTrapFtrInit				equ	41593
sysTrapFtrUnregister			equ	41594
sysTrapFtrGet				equ	41595
sysTrapFtrSet				equ	41596
sysTrapFtrGetByIndex			equ	41597

sysTrapGrfInit				equ	41598
sysTrapGrfFree				equ	41599
sysTrapGrfGetState			equ	41600
sysTrapGrfSetState			equ	41601
sysTrapGrfFlushPoints			equ	41602
sysTrapGrfAddPoint			equ	41603
sysTrapGrfInitState			equ	41604
sysTrapGrfCleanState			equ	41605
sysTrapGrfMatch				equ	41606
sysTrapGrfGetMacro			equ	41607
sysTrapGrfFilterPoints			equ	41608
sysTrapGrfGetNumPoints			equ	41609
sysTrapGrfGetPoint			equ	41610
sysTrapGrfFindBranch			equ	41611
sysTrapGrfMatchGlyph			equ	41612
sysTrapGrfGetGlyphMapping		equ	41613
sysTrapGrfGetMacroName			equ	41614
sysTrapGrfDeleteMacro			equ	41615
sysTrapGrfAddMacro			equ	41616
sysTrapGrfGetAndExpandMacro		equ	41617
sysTrapGrfProcessStroke			equ	41618
sysTrapGrfFieldChange			equ	41619

sysTrapGetCharSortValue			equ	41620
sysTrapGetCharAttr			equ	41621
sysTrapGetCharCaselessValue		equ	41622

sysTrapPwdExists			equ	41623
sysTrapPwdVerify			equ	41624
sysTrapPwdSet				equ	41625
sysTrapPwdRemove			equ	41626

sysTrapGsiInitialize			equ	41627
sysTrapGsiSetLocation			equ	41628
sysTrapGsiEnable			equ	41629
sysTrapGsiEnabled			equ	41630
sysTrapGsiSetShiftState			equ	41631

sysTrapKeyInit				equ	41632
sysTrapKeyHandleInterrupt		equ	41633
sysTrapKeyCurrentState			equ	41634
sysTrapKeyResetDoubleTap		equ	41635
sysTrapKeyRates				equ	41636
sysTrapKeySleep				equ	41637
sysTrapKeyWake				equ	41638

sysTrapDlkControl			equ	41639

sysTrapDlkStartServer			equ	41640
sysTrapDlkGetSyncInfo			equ	41641
sysTrapDlkSetLogEntry			equ	41642

sysTrapUnused2				equ	41643
sysTrapSysLibLoad			equ	41644
sysTrapSndPlaySmf			equ	41645
sysTrapSndCreateMidiList		equ	41646

sysTrapAbtShowAbout			equ	41647

sysTrapMdmDial				equ	41648
sysTrapMdmHangUp			equ	41649

sysTrapDmSearchRecord			equ	41650

sysTrapSysInsertionSort			equ	41651
sysTrapDmInsertionSort			equ	41652

sysTrapLstSetTopItem			equ	41653

; PalmOS 2.X traps
sysTrapSclSetScrollBar			equ	41654
sysTrapSclDrawScrollBar			equ	41655
sysTrapSclHandleEvent			equ	41656

sysTrapSysMailboxCreate			equ	41657
sysTrapSysMailboxDelete			equ	41658
sysTrapSysMailboxFlush			equ	41659
sysTrapSysMailboxSend			equ	41660
sysTrapSysMailboxWait			equ	41661

sysTrapSysTaskWait			equ	41662
sysTrapSysTaskWake			equ	41663
sysTrapSysTaskWaitClr			equ	41664
sysTrapSysTaskSuspend			equ	41665
sysTrapSysTaskResume			equ	41666

sysTrapCategoryCreateList		equ	41667
sysTrapCategoryFreeList			equ	41668
sysTrapCategoryEditV20			equ	41669
sysTrapCategorySelect			equ	41670

sysTrapDmDeleteCategory			equ	41671

sysTrapSysEvGroupCreate			equ	41672
sysTrapSysEvGroupSignal			equ	41673
sysTrapSysEvGroupRead			equ	41674
sysTrapSysEvGroupWait			equ	41675

sysTrapEvtEventAvail			equ	41676
sysTrapEvtSysEventAvail			equ	41677
sysTrapStrNCopy				equ	41678

sysTrapKeySetMask			equ	41679

sysTrapSelectDay			equ	41680

sysTrapPrefGetPreference		equ	41681
sysTrapPrefSetPreference		equ	41682
sysTrapPrefGetAppPreferences		equ	41683
sysTrapPrefSetAppPreferences		equ	41684

sysTrapFrmPointInTitle			equ	41685

sysTrapStrNCat				equ	41686

sysTrapMemCmp				equ	41687

sysTrapTblSetColumnEditIndicator	equ	41688

sysTrapFntWordWrap			equ	41689

sysTrapFldGetScrollValues		equ	41690

sysTrapSysCreateDataBaseList		equ	41691
sysTrapSysCreatePanelList		equ	41692

sysTrapDlkDispatchRequest		equ	41693

sysTrapStrPrintF			equ	41694
sysTrapStrVPrintF			equ	41695

sysTrapPrefOpenPreferenceDB		equ	41696

sysTrapSysGraffitiReferenceDialog	equ	41697

sysTrapSysKeyboardDialog		equ	41698

sysTrapFntWordWrapReverseNLines		equ	41699
sysTrapFntGetScrollValues		equ	41700

sysTrapTblSetRowStaticHeight		equ	41701
sysTrapTblHasScrollBar			equ	41702

sysTrapSclGetScrollBar			equ	41703

sysTrapFldGetNumberOfBlankLines		equ	41704

sysTrapSysTicksPerSecond		equ	41705
sysTrapHwrBacklight			equ	41706
sysTrapHwrDisplayAttributes		equ 	41842
sysTrapDmDatabaseProtect		equ	41707

sysTrapTblSetBounds			equ	41708

sysTrapStrNCompare			equ	41709
sysTrapStrNCaselessCompare		equ	41710

sysTrapPhoneNumberLookup		equ	41711

sysTrapFrmSetMenu			equ	41712

sysTrapEncDigestMD5			equ	41713

sysTrapDmFindSortPosition		equ	41714

sysTrapSysBinarySearch			equ	41715
sysTrapSysErrString			equ	41716
sysTrapSysStringByIndex			equ	41717

sysTrapEvtAddUniqueEventToQueue		equ	41718

sysTrapStrLocalizeNumber		equ	41719
sysTrapStrDelocalizeNumber		equ	41720
sysTrapLocGetNumberSeparators		equ	41721

sysTrapMenuSetActiveMenuRscID		equ	41722

sysTrapLstScrollList			equ	41723

sysTrapCategoryInitialize		equ	41724

sysTrapEncDigestMD4			equ	41725
sysTrapEncDES				equ	41726

sysTrapLstGetVisibleItems		equ	41727

sysTrapWinSetWindowBounds		equ	41728

sysTrapCategorySetName			equ	41729

sysTrapFldSetInsertionPoint		equ	41730

sysTrapFrmSetObjectBounds		equ	41731

sysTrapWinSetColors			equ	41732

sysTrapFlpDispatch			equ	41733
sysTrapFlpEmDispatch			equ	41734

sysTrapPceNativeCall			equ	42074

sysLibTrapSerName             equ 43008
sysLibTrapSerOpen             equ 43009
sysLibTrapSerClose            equ 43010
sysLibTrapSerSleep            equ 43011
sysLibTrapSerWake             equ 43012
sysLibTrapSerGetSettings      equ 43013
sysLibTrapSerSetSettings      equ 43014
sysLibTrapSerGetStatus        equ 43015
sysLibTrapSerClearErr         equ 43016
sysLibTrapSerSend10           equ 43017
sysLibTrapSerSendWait         equ 43018
sysLibTrapSerSendCheck        equ 43019
sysLibTrapSerSendFlush        equ 43020
sysLibTrapSerReceive10        equ 43021
sysLibTrapSerReceiveWait      equ 43022
sysLibTrapSerReceiveCheck     equ 43023
sysLibTrapSerReceiveFlush     equ 43024
sysLibTrapSerSetReceiveBuffer equ 43025
; defined for system use only
sysLibTrapSerReceiveWindowOpen equ $0A805+13
sysLibTrapSerReceiveWindowClose equ $0A805+14
sysLibTrapSerSetWakeupHandler equ $0A805+15
sysLibTrapSerPrimeWakeupHandler equ $0A805+16
sysLibTrapSerControl	      equ $0A805+17
; from PalmOS 2.0
sysLibTrapSerSend             equ $0A805+18
sysLibTrapSerReceive          equ $0A805+19

; system\DLServer.h  -- RCM 10/15/01
; DirectLink Server (Hotsync) functions
sysTrapDlkGetSyncInfo		equ $0A2A9	; allows us to get the User Name

; PalmOS 3.5 traps
sysTrapBltFindIndexes	        equ $A375
sysTrapBmpGetBits	            equ $A376
sysTrapBltCopyRectangle	        equ $A377
sysTrapBltDrawChars	            equ $A378
sysTrapBltLineRoutine	        equ $A379
sysTrapBltRectangleRoutine	    equ $A37A
sysTrapScrCompress	            equ $A37B
sysTrapScrDecompress	        equ $A37C
sysTrapSysLCDBrightness	        equ $A37D
sysTrapWinPaintChar	            equ $A37E
sysTrapWinPaintChars	        equ 41855
sysTrapWinPaintBitmap	        equ $A380
sysTrapWinGetPixel	            equ $A381
sysTrapWinPaintPixel	        equ $A382
sysTrapWinDrawPixel	            equ $A383
sysTrapWinErasePixel	        equ $A384
sysTrapWinInvertPixel	        equ $A385
sysTrapWinPaintPixels	        equ $A386
sysTrapWinPaintLines	        equ $A387
sysTrapWinPaintLine	            equ $A388
sysTrapWinPaintRectangle	    equ $A389
sysTrapWinPaintRectangleFrame	equ $A38A
sysTrapWinPaintPolygon	        equ $A38B
sysTrapWinDrawPolygon	        equ $A38C
sysTrapWinErasePolygon	        equ $A38D
sysTrapWinInvertPolygon	        equ $A38E
sysTrapWinFillPolygon	        equ $A38F
sysTrapWinPaintArc	            equ $A390
sysTrapWinDrawArc	            equ $A391
sysTrapWinEraseArc	            equ $A392
sysTrapWinInvertArc	            equ $A393
sysTrapWinFillArc	            equ $A394
sysTrapWinPushDrawState	        equ 41877
sysTrapWinPopDrawState          equ 41878
sysTrapWinSetDrawMode	        equ 41879
sysTrapWinSetForeColor          equ 41880
sysTrapWinRGBToIndex            equ 41886
sysTrapWinCreateBitmapWindow	equ 41956

; system\bitmap.h  -- RCM 10/15/01
; Window bitmap functions
sysTrapBmpCreate		equ $0A3DD
sysTrapBmpDelete		equ $0A3DE
sysTrapBmpCompress		equ $0A3DF
sysTrapBmpGetColortable		equ $0A3E0
sysTrapBmpGetBits		equ $0A376  	;  was BltGetBitsAddr
sysTrapBmpSize			equ $0A3E1
sysTrapBmpBitsSize		equ $0A3E2
sysTrapBmpColortableSize	equ $0A3E3
sysTrapWinCreateBitmapWindow	equ $0A3E4
sysTrapWinGetBitmap             equ $0A3A2
sysTrapWinPalette               equ $0A39D
sysTrapWinPaintBitmap           equ $0A380


; PalmOS 3.X traps
sysTrapExgInit				equ	41735
sysTrapExgConnect			equ	41736
sysTrapExgPut				equ	41737
sysTrapExgGet				equ	41738
sysTrapExgAccept			equ	41739
sysTrapExgDisconnect			equ	41740
sysTrapExgSend				equ	41741
sysTrapExgReceive			equ	41742
sysTrapExgRegisterData			equ	41743
sysTrapExgNotifyReceive			equ	41744
sysTrapExgControl			equ	41745

sysTrapPrgStartDialog			equ	41746
sysTrapPrgStopDialog			equ	41747
sysTrapPrgUpdateDialog			equ	41748
sysTrapPrgHandleEvent			equ	41749

sysTrapImcReadFieldNoSemicolon		equ	41750
sysTrapImcReadFieldQuotablePrintable	equ	41751
sysTrapImcReadPropertyParameter		equ	41752
sysTrapImcSkipAllPropertyParameters	equ	41753
sysTrapImcReadWhiteSpace		equ	41754
sysTrapImcWriteQuotedPrintable		equ	41755
sysTrapImcWriteNoSemicolon		equ	41756
sysTrapImcStringIsAscii			equ	41757

sysTrapTblGetItemFont			equ	41758
sysTrapTblSetItemFont			equ	41759

sysTrapFontSelect			equ	41760
sysTrapFntDefineFont			equ	41761

sysTrapCategoryEdit			equ	41762

sysTrapSysGetOSVersionString		equ	41763
sysTrapSysBatteryInfo			equ	41764
sysTrapSysUIBusy			equ	41765

sysTrapWinValidateHandle		equ	41766
sysTrapFrmValidatePtr			equ	41767
sysTrapCtlValidatePointer		equ	41768
sysTrapWinMoveWindowAddr		equ	41769
sysTrapFrmAddSpaceForObject		equ	41770
sysTrapFrmNewForm			equ	41771
sysTrapCtlNewControl			equ	41772
sysTrapFldNewField			equ	41773
sysTrapLstNewList			equ	41774
sysTrapFrmNewLabel			equ	41775
sysTrapFrmNewBitmap			equ	41776
sysTrapFrmNewGadget			equ	41777

sysTrapFileOpen				equ	41778
sysTrapFileClose			equ	41779
sysTrapFileDelete			equ	41780
sysTrapFileReadLow			equ	41781
sysTrapFileWrite			equ	41782
sysTrapFileSeek				equ	41783
sysTrapFileTell				equ	41784
sysTrapFileTruncate			equ	41785
sysTrapFileControl			equ	41786

sysTrapFrmActiveState			equ	41787

sysTrapSysGetAppInfo			equ	41788
sysTrapSysGetStackInfo			equ	41789

sysTrapScrDisplayMode			equ	41790
; determine the screen mode of our device
sysTrapWinScreenMode            equ sysTrapScrDisplayMode  ; was sysTrapScrDisplayMode
sysTrapHwrLCDGetDepth			equ	41791
sysTrapHwrGetROMToken			equ	41792

sysTrapDbgControl			equ	41793

sysTrapExgDBRead			equ	41794
sysTrapExgDBWrite			equ	41795

sysTrapSysGremlins			equ	41796
sysTrapHostControl			equ	sysTrapSysGremlins	; renamed
sysTrapFrmRemoveObject			equ	41797

sysTrapSysReserved1			equ	41798
sysTrapExpansionDispatch	equ	41799
sysTrapSysReserved3			equ	41800
sysTrapSysReserved4			equ	41801

sysTrapLastTrapNumber			equ	41802

sysNumTraps		equ	sysTrapLastTrapNumber - sysTrapBase


sysLibTrapBase			equ	$A800
sysLibTrapName			equ	$A800
sysLibTrapOpen			equ	$A801
sysLibTrapClose			equ	$A802
sysLibTrapSleep			equ	$A803
sysLibTrapWake			equ	$A804
sysLibTrapCustom		equ	$A805


sysDbgBreakpointTrapNum		equ	0
sysDbgTrapNum			equ	8
sysDispatchTrapNum		equ	15


; Palm Networking Library calls -- RCM 1/25/02
sysLibTrapNetLibOpen     equ sysLibTrapOpen
sysLibTrapNetLibClose    equ sysLibTrapClose
sysLibTrapNetLibSleep    equ sysLibTrapSleep
sysLibTrapNetLibWake     equ sysLibTrapWake
sysLibTrapNetLibAddrINToA	equ sysLibTrapCustom
sysLibTrapNetLibAddrAToIN	equ sysLibTrapCustom+1
sysLibTrapNetLibSocketOpen	equ sysLibTrapCustom+2
sysLibTrapNetLibSocketClose	equ sysLibTrapCustom+3
sysLibTrapNetLibSocketOptionGet	equ sysLibTrapCustom+5
sysLibTrapNetLibSocketOptionSet	equ sysLibTrapCustom+4
sysLibTrapNetLibSocketConnect	equ sysLibTrapCustom+7
sysLibTrapNetLibSocketBind	equ sysLibTrapCustom+6
sysLibTrapNetLibSocketListen	equ sysLibTrapCustom+8
sysLibTrapNetLibSocketAccept	equ sysLibTrapCustom+9
sysLibTrapNetLibSocketShutdown	equ sysLibTrapCustom+10
sysLibTrapNetLibSend		equ sysLibTrapCustom+12
sysLibTrapNetLibReceive		equ sysLibTrapCustom+14
sysLibTrapNetLibGetHostByName	equ sysLibTrapCustom+22
sysLibTrapNetLibOpenCount	equ	sysLibTrapCustom+41
sysLibTrapNetLibConnectionRefresh	equ	sysLibTrapCustom+46


; AppBuildRules.h

SHELL_COMMAND_DB	equ	0
SHELL_COMMAND_UI	equ	0
SHELL_COMMAND_APP	equ	0
SHELL_COMMAND_EMULATOR	equ	1

; Core\CoreTraps.h -- KP 3/21/02
sysTrapSerialDispatch		equ	$0A367
sysSerialInstall			equ	0
sysSerialOpen				equ	1
sysSerialOpenBkgnd			equ	2
sysSerialClose				equ	3
sysSerialSleep				equ	4
sysSerialWake				equ	5
sysSerialGetDeviceCount		equ	6
sysSerialGetDeviceInfo		equ	7
sysSerialGetStatus			equ	8
sysSerialClearErr			equ	9
sysSerialControl			equ	10
sysSerialSend				equ	11
sysSerialSendWait			equ	12
sysSerialSendCheck			equ	13
sysSerialSendFlush			equ	14
sysSerialReceive			equ	15
sysSerialReceiveWait		equ	16
sysSerialReceiveCheck		equ	17
sysSerialReceiveFlush		equ	18
sysSerialSetRcvBuffer		equ	19
sysSerialRcvWindowOpen		equ	20
sysSerialRcvWindowClose		equ	21
sysSerialSetWakeupHandler	equ	22
sysSerialPrimeWakeupHandler	equ	23
sysSerialOpenV4				equ	24
sysSerialOpenBkgndV4		equ	25
sysSerialCustomControl		equ 26


; BuildRules.h

EMULATION_NONE		equ	0
EMULATION_WINDOWS	equ	1
EMULATION_DOS		equ	2
EMULATION_MAC		equ	3

MEMORY_LOCAL		equ	0
MEMORY_REMOTE		equ	1

ENVIRONMENT_CW		equ	0
ENVIRONMENT_MPW		equ	1

ERROR_CHECK_NONE	equ	0
ERROR_CHECK_PARTIAL	equ	1
ERROR_CHECK_FULL	equ	2

CPU_68K			equ	0
CPU_x86			equ	1

HW_TARGET_NONE		equ	0
HW_TARGET_302		equ	1
HW_TARGET_328EMU	equ	2
HW_TARGET_328		equ	3
HW_TARGET_TD1		equ	4

MEMORY_FORCE_LOCK_OFF	equ	0
MEMORY_FORCE_LOCK_ON	equ	1

DEBUG_LEVEL_NONE	equ	1
DEBUG_LEVEL_PARTIAL	equ	2
DEBUG_LEVEL_FULL	equ	3

CONSOLE_SERIAL_LIB_68328	equ	1
CONSOLE_SERIAL_LIB_68681	equ	2

COUNTRY_UNITED_STATES	equ	0
COUNTRY_FRANCE		equ	1
COUNTRY_GERMANY		equ	2
COUNTRY_ITALY		equ	3
COUNTRY_SPAIN		equ	4

LANGUAGE_ENGLISH	equ	0
LANGUAGE_FRENCH		equ	1
LANGUAGE_GERMAN		equ	2
LANGUAGE_ITALIAN	equ	3
LANGUAGE_SPANISH	equ	4
LANGUAGE_WORKPAD	equ	5

USER_MODE_NORMAL	equ	0
USER_MODE_DEMO		equ	1

INTERNAL_COMMANDS_EXCLUDE	equ	0
INTERNAL_COMMANDS_INCLUDE	equ	1

MEMORY_VERSION_1	equ	1
MEMORY_VERSION_2	equ	2

GRAPHICS_VERSION_1	equ	1
GRAPHICS_VERSION_2	equ	2

INCLUDE_DES_OFF		equ	0
INCLUDE_DES_ON		equ	1

EMULATION_LEVEL		equ	0
USE_TRAPS		equ	1

MEMORY_TYPE		equ	MEMORY_LOCAL
ENVIRONMENT		equ	ENVIRONMENT_CW
ERROR_CHECK_LEVEL	equ	ERROR_CHECK_FULL
CPU_TYPE		equ	CPU_68K
HW_TARGET		equ	HW_TARGET_NONE
MEMORY_FORCE_LOCK	equ	MEMORY_FORCE_LOCK_ON
COUNTRY			equ	COUNTRY_UNITED_STATES
LANGUAGE		equ	LANGUAGE_ENGLISH
USER_MODE		equ	USER_MODE_NORMAL
INTERNAL_COMMANDS	equ	INTERNAL_COMMANDS_EXCLUDE
MEMORY_VERSION		equ	MEMORY_VERSION_2
GRAPHICS_VERSION	equ	GRAPHICS_VERSION_2
;INCLUDE_DES		equ	INCUDE_DES_OFF


; Common.h

NULL	equ	0
true	equ	1
false	equ	0


; System\SystemMgr.h

sysAppLaunchCmdNormalLaunch	equ	0
sysAppLaunchCmdFind		equ	1
sysAppLaunchCmdGoTo		equ	2
sysAppLaunchCmdSyncNotify	equ	3
sysAppLaunchCmdTimeChange	equ	4
sysAppLaunchCmdSystemReset	equ	5
sysAppLaunchCmdAlarmTriggered	equ	6
sysAppLaunchCmdDisplayAlarm	equ	7
sysAppLaunchCmdCountryChange	equ	8
sysAppLaunchCmdSyncRequestLocal	equ	9
sysAppLaunchCmdSyncRequest	equ	sysAppLaunchCmdSyncRequestLocal
sysAppLaunchCmdSaveData		equ	10
sysAppLaunchCmdInitDatabase	equ	11
sysAppLaunchCmdSyncCallApplicationV10	equ	12
sysAppLaunchCmdPanelCalledFromApp	equ	13
sysAppLaunchCmdReturnFromPanel	equ	14
sysAppLaunchCmdLookup		equ	15
sysAppLaunchCmdSystemLock	equ	16
sysAppLaunchCmdSyncRequestRemote	equ	17
sysAppLaunchCmdHandleSyncCallApp	equ	18
sysAppLaunchCmdAddRecord	equ	19

sysSvcLaunchCmdSetServiceID	equ	20
sysSvcLaunchCmdGetServiceID	equ	21
sysSvcLaunchCmdGetServiceList	equ	22
sysSvcLaunchCmdGetServiceInfo	equ	23


sysAppLaunchCmdFailedAppNotify	equ	24
sysAppLaunchCmdEventHook	equ	25
sysAppLaunchCmdExgReceiveData	equ	26
sysAppLaunchCmdExgAskUser	equ	27

sysDialLaunchCmdDial		equ	30
sysDialLaunchCmdHangUp		equ	31
sysDialLaunchCmdLast		equ	39

sysSvcLaunchCmdGetQuickEditLabel	equ	40
sysSvcLaunchCmdLast		equ	49

sysAppLaunchCmdCustomBase	equ	$8000

sysAppLaunchFlagNewThread	equ	$01
sysAppLaunchFlagNewStack	equ	$02
sysAppLaunchFlagNewGlobals	equ	$04
sysAppLaunchFlagUIApp	equ	$08
sysAppLaunchFlagSubCall	equ	$10
sysAppLaunchFlagDataRelocated	equ	$80

sysAppLaunchFlagPrivateSet	equ	sysAppLaunchFlagSubCall | sysAppLaunchFlagDataRelocated

struct SysAppLaunchCmdSaveDataType
	uiComing.b
endstruct

struct SysAppLaunchCmdSystemResetType
	hardReset.b
	createDefaultDB.b
endstruct

struct SysAppLaunchCmdInitDatabaseType
	dbP.l
	creator.l
	type.l
	version.w
endstruct

struct SysAppLaunchCmdSyncCallApplicationTypeV10
	action.w
	paramSize.w
	paramP.l
	remoteSocket.b
	tid.b
	handled.b
	bPad.b
endstruct

struct SysAppLaunchCmdHandleSyncCallAppType
	pbSize.w
	action.w
	paramP.l
	dwParamSize.l
	dlRefP.l
	handled.b
	pad.b
	replyErr.w
	dwReserved1.l
	dwReserved2.l
endstruct

struct SysAppLaunchCmdFailedAppNotifyType
	creator.l
	type.l
	result.w
endstruct

struct SysLibTblEntryType
	dispatchTblP.l
	globalsP.l
	dbID.l
	codeRscH.l
endstruct

sysDbgCommLibraryRefNum	equ	0

sysInvalidRefNum	equ	$FFFF

memErrorClass	equ	$0100
dmErrorClass	equ	$0200
serErrorClass	equ	$0300
slkErrorClass	equ	$0400
sysErrorClass	equ	$0500
fplErrorClass	equ	$0600
flpErrorClass	equ	$0680
evtErrorClass	equ	$0700
sndErrorClass	equ	$0800
almErrorClass	equ	$0900
timErrorClass	equ	$0A00
penErrorClass	equ	$0B00
ftrErrorClass	equ	$0C00
cmpErrorClass	equ	$0D00
dlkErrorClass	equ	$0E00
padErrorClass	equ	$0F00
grfErrorClass	equ	$1000
mdmErrorClass	equ	$1100
netErrorClass	equ	$1200
htalErrorClass	equ	$1300
inetErrorClass	equ	$1400
exgErrorClass	equ	$1500
fileErrorClass	equ	$1600
rfutErrorClass	equ	$1700

appErrorClass	equ	$8000

sysErrTimeout		equ	sysErrorClass | 1
sysErrParamErr		equ	sysErrorClass | 2
sysErrNoFreeResource	equ	sysErrorClass | 3
sysErrNoFreeRAM		equ	sysErrorClass | 4
sysErrNotAllowed	equ	sysErrorClass | 5
sysErrSemInUse		equ	sysErrorClass | 6
sysErrInvalidID		equ	sysErrorClass | 7
sysErrOutOfOwnerIDs	equ	sysErrorClass | 8
sysErrNoFreeLibSlots	equ	sysErrorClass | 9
sysErrLibNotFound	equ	sysErrorClass | 10
sysErrDelayWakened	equ	sysErrorClass | 11
sysErrRomIncompatible	equ	sysErrorClass | 12

sysFtrCreator	equ	sysFileCSystem
sysFtrNumROMVersion	equ	1
;sysFtrNumProductID	equ	2	; Obsolete in 3.1+
sysFtrNumBacklight	equ	3
sysFtrNumEncryption	equ	4
sysFtrNumEncryptionMaskDES	equ	$00000001
sysFtrNumCountry	equ	5
sysFtrNumLanguage	equ	6
sysFtrNumDisplayDepth	equ	7

sysFtrNumProcessorID	equ	2	; 0xMMMMRRRR, where MMMM is the processor model and RRRR is the revision.
sysFtrNumProcessorMask	equ	$FFFF0000	; Mask to obtain processor model
sysFtrNumProcessor328	equ	$00010000	; Motorola 68328  (Dragonball)
sysFtrNumProcessorEZ	equ	$00020000	; Motorola 68EZ328  (Dragonball


sysROMTokenSnum	equ	'snum'




sysROMStageDevelopment	equ	0
sysROMStageAlpha	equ	1
sysROMStageBeta		equ	2
sysROMStageRelease	equ	3

; SysBatteryKind
sysBatteryKindAlkaline	equ	0
sysBatteryKindNiCad	equ	1
sysBatteryKindLithium	equ	2


struct SysDBListItemType
	name.32
	creator.l
	type.l
	version.w
	dbID.l
	cardNo.w
	iconP.l
endstruct

struct SysMailboxMsgType
	data.12
endstruct

sysEvGroupSignalConstant	equ	0
sysEvGroupSignalPulse	equ	1
sysEvGroupWaitOR	equ	0
sysEvGroupWaitAND	equ	1

sysFileDescStdIn	equ	0


; System\SysUtils.h

sysRandomMax	equ	$7FFF


; System\SystemPrv.h

sysCardSignature	equ	$FEEDBEEF
sysStoreSignature	equ	$FEEDFACE

sysLowMemSize	equ	$1480
sysInitStack	equ	sysLowMemSize+$1000

sysRAMOnlyCardHeaderOffset	equ	$0000000
sysCardHeaderSize	equ	$0100

sysROMStoreRelOffset	equ	sysCardHeaderSize
sysStoreHeaderSize	equ	$0100

sysMaxHeapsPerCard	equ	128

;sysDefaultLibraries	equ	DEFAULT_LIB_ENTRIES

sysDefaultSerPort	equ	1
sysDefaultSerBaud	equ	57600

struct SysAppPrefs
	priority.w
	stackSize.l
	minHeapSpace.l
endstruct

struct SysAppInfoType
	cmd.w
	cmdPBP.l
	launchFlags.w
	taskID.l
	codeH.l
	dbP.l
	stackP.l
	globalsChunkP.l
	memOwnerID.w
	dmAccessP.l
	dmLastErr.w
	errExceptionP.l
	a5Ptr.l
	stackEndP.l
	globalEndP.l
	rootP.l
	extraP.l
endstruct

struct SysTCBUserInfoType
	tmpAppInfoP.l
	rootAppInfoP.l
	initialA5.l
endstruct

struct SysNVParamsType
	rtcHours.l
	rtcHourMinSecCopy.l
endstruct

sysFileDescNet	equ	sysFileDescStdIn+1

sysResetFlagHardReset	equ	$01
sysResetFlagCreateDefaultDBs	equ	$02
sysResetFlagNoExtensions	equ	$04

sysPrefFlagTaxiDisable	equ	$0001
sysPrefFlagEnableEasterEggs	equ	$0002
sysPrefFlagTaxiDisIdle	equ	$8000

sysPrefFlagTaxiDisIdleTime	equ	$4000

sysMiscFlagInFatalAlert	equ	$0001
sysMiscFlagAlwaysSwitchApp	equ	$0002

sysMiscFlagProfile	equ	$0004
sysMiscFlagGrfDisable	equ	$0008
sysMiscFlagInDemoAlert	equ	$0010
sysMiscFlagBacklightDisable	equ	$0020
sysMiscFlagUIInitialized	equ	$0040
sysMiscFlagExgEvent	equ	$0080

dbgEnteredFlagPseudoNMI	equ	$80


; Hardware\M68KHwr.h

m68kTrapInstr		equ	$4E40
m68kTrapVectorMask	equ	$000F

struct M68KExcTableType
	initStack.l
	initPC.l
	busErr.w
	addressErr.w
	illegalInstr.l
	divideByZero.l
	chk.l
	trap.l
	privilege.l
	trace.l
	aTrap.l
	fTrap.l
	reserved12.l
	coproc.l
	formatErr.w
	unitializedInt.l
	reserved.32
	spuriousInt.l
	autoVec1.l
	autoVec2.l
	autoVec3.l
	autoVec4.l
	autoVec5.l
	autoVec6.l
	autoVec7.l
	trapN.64
	unassigned.64
endstruct

struct M68KRegsType
	d.32
	a.28
	usp.l
	ssp.l
	pc.l
	sr.w
endstruct

m68kSrTraceMask		equ	$08000
m68kSrTraceBit		equ	15

m68kSrSupervisorMask	equ	$02000

m68kSrInterruptMask	equ	$00700

m68kSrExtendMask	equ	$00010
m68kSrNegativeMask	equ	$00008
m68kSrZeroMask		equ	$00004
m68kSrOverflowMask	equ	$00002
m68kSrCarryMask		equ	$00001


; System\SoundMgr.h

sndMaxAmp	equ	64
sndDefaultAmp	equ	sndMaxAmp
sndMidiNameLength	equ	32

; SndCmdIDType
sndCmdFreqDurationAmp	equ	1
sndCmdNoteOn	equ	2
sndCmdFrqOn	equ	3
sndCmdQuiet	equ	4

struct SndCommandType
	cmd.w
	param1.l
	param2.w
	param3.w
endstruct

; SndSysBeepType
sndInfo	equ	1
sndWarning	equ	2
sndError	equ	3
sndStartUp	equ	4
sndAlarm	equ	5
sndConfirmation	equ	6
sndClick	equ	7

sndMidiRecSignature	equ	'PMrc'

struct SndMidiRecHdrType
	signature.l
	bDataOffset.b
	reserved.b
endstruct

struct SndMidiRecType
	hdr.SndMidiRecHdrType
	name.b
endstruct

struct SndMidiListItemType
	name.32
	uniqueRecID.l
	dbID.l
	cardNo.w
endstruct

; SndSmfCmdEnum
sndSmfCmdPlay	equ	1
sndSmfCmdDuration	equ	2

struct SndCallbackInfoType
	funcP.l
	dwUserData.l
endstruct

struct SndSmfCallbacksType
	completion.l
	blocking.l
	reserved.l
endstruct

sndSmfPlayAllMilliSec	equ	$FFFFFFFF

struct SndSmfOptionsType
	dwStartMilliSec.l
	dwEndMilliSec.l
	amplitude.w
	interruptible.b
	pad.b
	reserved.l
endstruct

struct SndSmfChanRangeType
	bFirstChan.b
	bLastChan.b
endstruct

sndErrBadParam		equ	sndErrorClass | 1
sndErrBadChannel	equ	sndErrorClass | 2
sndErrMemory		equ	sndErrorClass | 3
sndErrOpen		equ	sndErrorClass | 4
sndErrQFull		equ	sndErrorClass | 5
sndErrQEmpty		equ	sndErrorClass | 6
sndErrFormat		equ	sndErrorClass | 7
sndErrBadStream		equ	sndErrorClass | 8
sndErrInterrupted	equ	sndErrorClass | 9


; System\SoundPrv.h

sndSamplingRate	equ	8000

sndBeepDurationMSec	equ	70
sndConfirmationDurationMSec	equ	70
sndClickDurationMSec	equ	9

sndInfoFreq	equ	500
sndWarningFreq	equ	500
sndErrorFreq	equ	500
sndConfirmationFreq	equ	500
sndStartUpFreq	equ	1000
sndClickFreq	equ	200

struct SndGlobalsType
	smID.l
	sysAmp.b
	alarmAmp.b
	defAmp.b
	pad.b
	wMidiFrqTabP.l
endstruct


; System\Preferences.h

noPreferenceFound	equ	-1

preferenceDataVersion	equ	4

defaultAutoOffDuration	equ	2

; SoundLevelTypeV20
slOn	equ	0
slOff	equ	1

defaultSysSoundLevel	equ	slOn
defaultGameSoundLevel	equ	slOn
defaultAlarmSoundLevel	equ	slOn

defaultSysSoundVolume	equ	sndMaxAmp
defaultGameSoundVolume	equ	sndMaxAmp
defaultAlarmSoundVolume	equ	sndMaxAmp

; CountryType;
cAustralia	equ	0
cAustria	equ	1
cBelgium	equ	2
cBrazil	equ	3
cCanada	equ	4
cDenmark	equ	5
cFinland	equ	6
cFrance	equ	7
cGermany	equ	8
cHongKong	equ	9
cIceland	equ	10
cIreland	equ	11
cItaly	equ	12
cJapan	equ	13
cLuxembourg	equ	14
cMexico	equ	15
cNetherlands	equ	16
cNewZealand	equ	17
cNorway	equ	18
cSpain	equ	19
cSweden	equ	20
cSwitzerland	equ	21
cUnitedKingdom	equ	22
cUnitedStates	equ	23

countryFirst	equ	cAustralia
countryLast	equ	cUnitedStates
countryCount	equ	countryLast - countryFirst + 1

;???typedef enum
;???	tfColon,
;???	tfColonAMPM,
;???	tfColon24h,
;???	tfDot,
;???	tfDotAMPM,
;???	tfDot24h,
;???	tfHoursAMPM,
;???	tfHours24h,
;???	tfComma24h
;???	} TimeFormatType;

;???typedef enum {
;???	dsNone,
;???	dsUSA,
;???	dsAustralia,
;???	dsWesternEuropean,
;???	dsMiddleEuropean,
;???	dsEasternEuropean,
;???	dsGreatBritain,
;???	dsRumania,
;???	dsTurkey,
;???	dsAustraliaShifted
;???	} DaylightSavingsTypes;

;???typedef enum {
;???	dfMDYWithSlashes,
;???	dfDMYWithSlashes,
;???	dfDMYWithDots,
;???	dfDMYWithDashes,
;???	dfYMDWithSlashes,
;???	dfYMDWithDots,
;???	dfYMDWithDashes,
;???	dfMDYLongWithComma,
;???	dfDMYLong,
;???	dfDMYLongWithDot,
;???	dfDMYLongNoDay,
;???	dfDMYLongWithComma,
;???	dfYMDLongWithDot,
;???	dfYMDLongWithSpace,
;???	dfMYMed,
;???	dfMYMedNoPost
;???	} DateFormatType;

;???typedef enum {
;???	nfCommaPeriod,
;???	nfPeriodComma,
;???	nfSpaceComma,
;???	nfApostrophePeriod,
;???	nfApostropheComma
;???	} NumberFormatType;

countryNameLength	equ	20
currencyNameLength	equ	20
currencySymbolLength	equ	6

;struct
;	CountryType country;					// Country the structure represents
;	countryName[countryNameLength].b
;	DateFormatType dateFormat;			// Format to display date in
;	longDateFormat.l
;	weekStartDay.b
;	TimeFormatType timeFormat;			// Format to display time in
;	NumberFormatType numberFormat;	// Format to display numbers in
;	currencyName[currencyNameLength].b
;	currencySymbol[currencySymbolLength].b
;	uniqueCurrencySymbol[currencySymbolLength].b
;	currencyDecimalPlaces.b
;	DaylightSavingsTypes	daylightSavings;	// Type of daylight savings correction
;	minutesWestOfGMT.l
;endstruct CountryPreferencesTypeCountryPreferencesType

;???typedef enum {
;???	alOff,
;???	alEventsOnly,
;???	alEventsAndRandom,
;???	alEventsAndMoreRandom
;???	} AnimationLevelType;

;???typedef enum
;???	prefVersion,
;???	prefCountry,
;???	prefDateFormat,
;???	prefLongDateFormat,
;???	prefWeekStartDay,
;???	prefTimeFormat,
;???	prefNumberFormat,
;???	prefAutoOffDuration,
;???	prefSysSoundLevelV20,
;???	prefGameSoundLevelV20,
;???	prefAlarmSoundLevelV20,
;???	prefHidePrivateRecords,
;???	prefDeviceLocked,
;???	prefLocalSyncRequiresPassword,
;???	prefRemoteSyncRequiresPassword,
;???	prefSysBatteryKind,
;???	prefAllowEasterEggs,
;???	prefMinutesWestOfGMT,
;???	prefDaylightSavings,
;???	prefRonamaticChar,
;???	prefHard1CharAppCreator,
;???	prefHard2CharAppCreator,
;???	prefHard3CharAppCreator,
;???	prefHard4CharAppCreator,
;???	prefCalcCharAppCreator,
;???	prefHardCradleCharAppCreator,
;???	prefLauncherAppCreator,
;???	prefSysPrefFlags,
;???	prefHardCradle2CharAppCreator,
;???	prefAnimationLevel,
;???	prefSysSoundVolume,
;???	prefGameSoundVolume,
;???	prefAlarmSoundVolume,
;???	prefBeamReceive,
;???	prefCalibrateDigitizerAtReset,
;???	prefSystemKeyboardID,
;???	prefDefSerialPlugIn
;???	} SystemPreferencesChoice;

;struct {
;	version.w
;	International.w
;	CountryType country;					// Country the device is in
;	DateFormatType dateFormat;			// Format to display date in
;	longDateFormat.l
;	weekStartDay.b
;	TimeFormatType timeFormat;			// Format to display time in
;	NumberFormatType numberFormat;	// Format to display numbers in
;
;	// system preferences
;	autoOffDuration.b
;	SoundLevelTypeV20 sysSoundLevel;		//	High, Med, Low, Off - error beeps
;	SoundLevelTypeV20 alarmSoundLevel;	//	High, Med, Low, Off - alarm only
;	hideSecretRecords.b
;	deviceLocked.b
;	sysPrefFlags.w
;	SysBatteryKind	sysBatteryKind;	// The type of batteries installed. This
;endstruct SystemPreferencesTypeV10SystemPreferencesTypeV10

struct SystemPreferencesTypeV10
    version.w
    country.b
    dateFormat.b
    longDateFormat.b
    weekStartDay.b
    timeFormat.b
    numberFormat.b
    autoOffDuration.b
    sysSoundLevel.b
    alarmSoundLevel.b
    hideSecretRecords.b
    deviceLocked.b
    bPad.b
    sysPrefFlags.w
    sysBatteryKind.b
    bPad2.b
endstruct

struct SystemPreferencesType
	version.w
	International.w
	country.b
	dateFormat.b
	longDateFormat.l
	weekStartDay.b
	timeFormat.b
	numberFormat.b
	autoOffDuration.b
	sysSoundLevelV20.b
	gameSoundLevelV20.b
	alarmSoundLevelV20.b
	hideSecretRecords.b
	deviceLocked.b
	localSyncRequiresPassword.b
	remoteSyncRequiresPassword.b
	pad.b
	sysPrefFlags.w
	sysBatteryKind.b
	pad2.b
	minutesWestOfGMT.l
	daylightSavings.b
	pad3.b
	romanaticChar.w
	hard1CharAppCreator.l
	hard2CharAppCreator.l
	hard3CharAppCreator.l
	hard4CharAppCreator.l
	calcCharAppCreator.l
	hardCradleCharAppCreator.l
	launcherCharAppCreator.l
	hardCradle2CharAppCreator.l
	animationLevel.b
	pad4.b
	sysSoundVolume.w
	gameSoundVolume.w
	alarmSoundVolume.w
	beamReceive.b
	calibrateDigitizerAtReset.b
	systemKeyboardID.w
	defSerialPlugIn.l
endstruct


; Hardware\M68328Hwr.h

struct HwrDBallType
	scr.b
	filler1.255
	csAGroupBase.w
	csBGroupBase.w
	csCGroupBase.w
	csDGroupBase.w
	csAGroupMask.w
	csBGroupMask.w
	csCGroupMask.w
	csDGroupMask.w
	csASelect0.l
	csASelect1.l
	csASelect2.l
	csASelect3.l
	csBSelect0.l
	csBSelect1.l
	csBSelect2.l
	csBSelect3.l
	csCSelect0.l
	csCSelect1.l
	csCSelect2.l
	csCSelect3.l
	csDSelect0.l
	csDSelect1.l
	csDSelect2.l
	csDSelect3.l
	csDebug.w
	filler2.174
	pllControl.w
	pllFreqSel.w
	pllTest.w
	filler44.b
	pwrControl.b
	filler3.248
	intVector.w
	filler4.b
	intControl.w
	intMaskHi.w
	intMaskLo.w
	intWakeupEnHi.w
	intWakeupEnLo.w
	intStatusHi.w
	intStatusLo.w
	intPendingHi.w
	intPendingLo.w
	filler4a.236
	portADir.b
	portAData.b
	filler5.b
	portASelect.b
	filler6.4
	portBDir.b
	portBData.b
	filler7.b
	portBSelect.b
	filler8.4
	portCDir.b
	portCData.b
	filler9.b
	portCSelect.b
	filler10.4
	portDDir.b
	portDData.b
	portDPullupEn.b
	filler11.b
	portDPolarity.b
	portDIntReqEn.w
	filler12.b
	portDIntEdge.w
	portEDir.b
	portEData.b
	portEPullupEn.b
	portESelect.b
	filler14.4
	portFDir.b
	portFData.b
	portFPullupEn.b
	portFSelect.b
	filler16.4
	portGDir.b
	portGData.b
	portGPullupEn.b
	portGSelect.b
	filler18.4
	portJDir.b
	portJData.b
	filler19.b
	portJSelect.b
	filler19a.4
	portKDir.b
	portKData.b
	portKPullupEn.b
	portKSelect.b
	filler21.4
	portMDir.b
	portMData.b
	portMPullupEn.b
	portMSelect.b
	filler22.4
	filler23.176
	pwmControl.w
	pwmPeriod.w
	pwmWidth.w
	pwmCounter.w
	filler24.248
	tmr1Control.w
	tmr1Prescaler.w
	tmr1Compare.w
	tmr1Capture.w
	tmr1Counter.w
	tmr1Status.w
	tmr2Control.w
	tmr2Prescaler.w
	tmr2Compare.w
	tmr2Capture.w
	tmr2Counter.w
	tmr2Status.w
	wdControl.w
	wdReference.w
	wdCounter.w
	filler25.226
	spiSlave.w
	filler26.254
	spiMasterData.w
	spiMasterControl.w
	filler27.252
	uControl.w
	uBaud.w
	uReceive.w
	uTransmit.w
	uMisc.w
	filler28.246
	lcdStartAddr.l
	filler29.b
	lcdPageWidth.b
	filler30.2
	lcdScreenWidth.w
	lcdScreenHeight.w
	filler31.12
	lcdCursorXPos.w
	lcdCursorYPos.w
	lcdCursorWidthHeight.w
	filler32.b
	lcdBlinkControl.b
	lcdPanelControl.w
	lcdPolarity.b
	filler33.b
	lcdACDRate.b
	filler34.b
	lcdPixelClock.b
	filler35.b
	lcdClockControl.b
	filler36.b
	lcdLastBufferAddr.b
	filler37.b
	lcdOctetTermCount.b
	filler38.b
	lcdPanningOffset.b
	filler39.3
	lcdFrameRate.b
	lcdGrayPalette.w
	lcdReserved.b
	filler40.203
	rtcHourMinSec.l
	rtcAlarm.l
	rtcReserved.l
	rtcControl.w
	rtcIntStatus.w
	rtcIntEnable.w
	stopWatch.w
endstruct

hwr328LcdCursorXPosCtlMask	equ	$C000
hwr328LcdCursorXPosCtlTrans	equ	$0000
hwr328LcdCursorXPosCtlBlack	equ	$4000
hwr328LcdCursorXPosCtlReverse	equ	$8000

hwr328LcdBlinkControlEnable	equ	$80

hwr328LcdPanelControlBusMask	equ	$06
hwr328LcdPanelControlBus1Bit	equ	$00
hwr328LcdPanelControlBus2Bit	equ	$02
hwr328LcdPanelControlBus4Bit	equ	$04
hwr328LcdPanelControlGrayScale	equ	$01

hwr328LcdPolarityShiftClock	equ	$08
hwr328LcdPolarityFLM		equ	$04
hwr328LcdPolarityLP		equ	$02
hwr328LcdPolarityPixel		equ	$01

hwr328LcdClockControlEnable	equ	$80
hwr328LcdClockControl16WordBursts	equ	$40
hwr328LcdClockControlBurstRateMask	equ	$30

hwr328LcdClockControlBurstRate1		equ	$00
hwr328LcdClockControlBurstRate2		equ	$04
hwr328LcdClockControlBurstRate3		equ	$08
hwr328LcdClockControlBurstRate4		equ	$0C
hwr328LcdClockControlBurstRate5		equ	$10
hwr328LcdClockControlBurstRate6		equ	$14
hwr328LcdClockControlBurstRate7		equ	$18
hwr328LcdClockControlBurstRate8		equ	$1C
hwr328LcdClockControlBurstRate9		equ	$20
hwr328LcdClockControlBurstRate10	equ	$24
hwr328LcdClockControlBurstRate11	equ	$28
hwr328LcdClockControlBurstRate12	equ	$2C
hwr328LcdClockControlBurstRate13	equ	$30
hwr328LcdClockControlBurstRate14	equ	$34
hwr328LcdClockControlBurstRate15	equ	$38
hwr328LcdClockControlBurstRate16	equ	$3C

hwr328LcdClockControl8BitBus		equ	$02
hwr328LcdClockControlPixelClkSrc	equ	$01

hwr328IntHiNMI		equ	$0080
hwr328IntHiTimer1	equ	$0040
hwr328IntHiSPIS		equ	$0020
hwr328IntHiPen		equ	$0010
hwr328IntHiIRQ6		equ	$0008
hwr328IntHiIRQ3		equ	$0004
hwr328IntHiIRQ2		equ	$0002
hwr328IntHiIRQ1		equ	$0001

hwr328IntHiIRQ6Clr	equ	$0001
hwr328IntHiIRQ3Clr	equ	$0002
hwr328IntHiIRQ2Clr	equ	$0004
hwr328IntHiIRQ1Clr	equ	$0008

hwr328IntLoInt7		equ	$8000
hwr328IntLoInt6		equ	$4000
hwr328IntLoInt5		equ	$2000
hwr328IntLoInt4		equ	$1000
hwr328IntLoInt3		equ	$0800
hwr328IntLoInt2		equ	$0400
hwr328IntLoInt1		equ	$0200
hwr328IntLoInt0		equ	$0100
hwr328IntLoAllKeys	equ	$FF00
hwr328IntLoInt0Bit	equ	8
hwr328IntLoPWM		equ	$0080
hwr328IntLoPWMBit	equ	7
hwr328IntLoKbd		equ	$0040
hwr328IntLoLCDC		equ	$0020
hwr328IntLoRTC		equ	$0010
hwr328IntLoRTCBit	equ	4
hwr328IntLoWDT		equ	$0008
hwr328IntLoUART		equ	$0004
hwr328IntLoUARTBit	equ	2
hwr328IntLoTimer2	equ	$0002
hwr328IntLoTimer2Bit	equ	1
hwr328IntLoSPIM		equ	$0001

hwr328IntCtlEdge1	equ	$0800
hwr328IntCtlEdge2	equ	$0400
hwr328IntCtlEdge3	equ	$0200
hwr328IntCtlEdge6	equ	$0100
hwr328IntCtlPol1	equ	$8000
hwr328IntCtlPol2	equ	$4000
hwr328IntCtlPol3	equ	$2000
hwr328IntCtlPol6	equ	$1000

hwr328TmrControlUnused			equ	$FE00
hwr328TmrControlFreeRun			equ	$0100
hwr328TmrControlCaptureEdgeMask		equ	$00C0
hwr328TmrControlCaptureEdgeNone		equ	$0000
hwr328TmrControlCaptureEdgeRising	equ	$0040
hwr328TmrControlCaptureEdgeFalling	equ	$0080
hwr328TmrControlCaptureEdgeBoth		equ	$00C0
hwr328TmrControlOutputModeToggle	equ	$0020
hwr328TmrControlEnInterrupt		equ	$0010
hwr328TmrControlClkSrcMask		equ	$000E
hwr328TmrControlClkSrcStop		equ	$0000
hwr328TmrControlClkSrcSys		equ	$0002
hwr328TmrControlClkSrcSysBy16		equ	$0004
hwr328TmrControlClkSrcTIN		equ	$0006
hwr328TmrControlClkSrc32KHz		equ	$0008
hwr328TmrControlEnable			equ	$0001

hwr328TmrStatusCapture		equ	$0002
hwr328TmrStatusCaptureBit	equ	1
hwr328TmrStatusCompare		equ	$0001
hwr328TmrStatusCompareBit	equ	0

hwr328UControlUARTEnable	equ	$8000
hwr328UControlRxEnable		equ	$4000
hwr328UControlTxEnable		equ	$2000
hwr328UControlRxClock1x		equ	$1000
hwr328UControlParityEn		equ	$0800
hwr328UControlParityOdd		equ	$0400
hwr328UControlStopBits2		equ	$0200
hwr328UControlDataBits8		equ	$0100
hwr328UControlGPIODeltaEn	equ	$0080
hwr328UControlCTSDeltaEn	equ	$0040
hwr328UControlRxFullEn		equ	$0020
hwr328UControlRxHalfEn		equ	$0010
hwr328UControlRxRdyEn		equ	$0008
hwr328UControlTxEmptyEn		equ	$0004
hwr328UControlTxHalfEn		equ	$0002
hwr328UControlTxAvailEn		equ	$0001

hwr328UControlEnableAll		equ	hwr328UControlUARTEnable | hwr328UControlRxEnable | hwr328UControlTxEnable

hwr328UBaudGPIODelta		equ	$8000
hwr328UBaudGPIOData		equ	$4000
hwr328UBaudGPIODirOut		equ	$2000
hwr328UBaudGPIOSrcBaudGen	equ	$1000
hwr328UBaudBaudSrcGPIO		equ	$0800
hwr328UBaudDivider		equ	$0700
hwr328UBaudPrescaler		equ	$003F

hwr328UBaudDivideBitOffset	equ	8

hwr328UReceiveFIFOFull		equ	$8000
hwr328UReceiveFIFOHalf		equ	$4000
hwr328UReceiveDataRdy		equ	$2000
hwr328UReceiveDataRdyBit	equ	13
hwr328UReceiveOverrunErr	equ	$0800
hwr328UReceiveOverrunErrBit	equ	11
hwr328UReceiveFrameErr		equ	$0400
hwr328UReceiveFrameErrBit	equ	10
hwr328UReceiveBreakErr		equ	$0200
hwr328UReceiveBreakErrBit	equ	9
hwr328UReceiveParityErr		equ	$0100
hwr328UReceiveParityErrBit	equ	8
hwr328UReceiveData		equ	$00FF

hwr328UReceiveErrsMask		equ	hwr328UReceiveOverrunErr | hwr328UReceiveFrameErr | hwr328UReceiveBreakErr | hwr328UReceiveParityErr

hwr328UTransmitFIFOEmpty	equ	$8000
hwr328UTransmitFIFOHalf		equ	$4000
hwr328UTransmitTxAvail		equ	$2000
hwr328UTransmitSendBreak	equ	$1000
hwr328UTransmitIgnoreCTS	equ	$0800
hwr328UTransmitCTSStatus	equ	$0200
hwr328UTransmitCTSDelta		equ	$0100
hwr328UTransmitData		equ	$00FF

hwr328UMiscClkSrcGPIO		equ	$4000
hwr328UMiscForceParityErr	equ	$2000
hwr328UMiscLoopback		equ	$1000
hwr328UMiscReservedMask		equ	$8F00
hwr328UMiscRTSThruFIFO		equ	$0080
hwr328UMiscRTSOut		equ	$0040
hwr328UMiscIRDAEn		equ	$0020
hwr328UMiscLoopIRDA		equ	$0010
hwr328UMiscUnused		equ	$000F

hwr328PWMControlEnable		equ	$0010
hwr328PWMControlEnableBit	equ	4
hwr328PWMControlEnableIRQ	equ	$4000
hwr328PWMControlLoad		equ	$0100
hwr328PWMIRQStatus		equ	$8000

hwr328PWMControlDivMask		equ	$0007
hwr328PWMControlDivBy2		equ	$0
hwr328PWMControlDivBy4		equ	$1
hwr328PWMControlDivBy8		equ	$2
hwr328PWMControlDivBy16		equ	$3
hwr328PWMControlDivBy32		equ	$4
hwr328PWMControlDivBy64		equ	$5
hwr328PWMControlDivBy128	equ	$6
hwr328PWMControlDivBy256	equ	$7

hwr328PLLControlDisable		equ	$0008
hwr328PLLControlClkEn		equ	$0010

hwr328PLLControlSysVCODiv2	equ	$0000
hwr328PLLControlSysVCODiv4	equ	$0100
hwr328PLLControlSysVCODiv8	equ	$0200
hwr328PLLControlSysVCODiv16	equ	$0300
hwr328PLLControlSysVCODiv1	equ	$0400

hwr328PLLControlPixVCODiv2	equ	$0000
hwr328PLLControlPixVCODiv4	equ	$080
hwr328PLLControlPixVCODiv8	equ	$1000
hwr328PLLControlPixVCODiv16	equ	$1800
hwr328PLLControlPixVCODiv1	equ	$2000

hwr328RTCControlRTCEnable	equ	$80
hwr328RTCControlRefSelMask	equ	$20
hwr328RTCControlRefSel38400	equ	$20
hwr328RTCControlRefSel32768	equ	$00

hwr328RTCIntEnableSec		equ	$10
hwr328RTCIntEnable24Hr		equ	$08
hwr328RTCIntEnableAlarm		equ	$04
hwr328RTCIntEnableMinute	equ	$02
hwr328RTCIntEnableStopWatch	equ	$01

hwr328RTCIntStatusSec		equ	$10
hwr328RTCIntStatus24Hr		equ	$08
hwr328RTCIntStatusAlarm		equ	$04
hwr328RTCIntStatusMinute	equ	$02
hwr328RTCIntStatusStopWatch	equ	$01

hwr328RTCAlarmSecondsMask	equ	$0000003f
hwr328RTCAlarmSecondsOffset	equ	0
hwr328RTCAlarmMinutesMask	equ	$003f0000
hwr328RTCAlarmMinutesOffset	equ	16
hwr328RTCAlarmHoursMask		equ	$1f000000
hwr328RTCAlarmHoursOffset	equ	24


hwr328RTCHourMinSecSecondsMask		equ	$0000003f
hwr328RTCHourMinSecSecondsOffset	equ	0
hwr328RTCHourMinSecMinutesMask		equ	$003f0000
hwr328RTCHourMinSecMinutesOffset	equ	16
hwr328RTCHourMinSecHoursMask		equ	$1f000000
hwr328RTCHourMinSecHoursOffset		equ	24

hwr328SPIMControlRateMask	equ	$E000
hwr328SPIMControlRateDiv4	equ	$0000
hwr328SPIMControlRateDiv8	equ	$2000
hwr328SPIMControlRateDiv16	equ	$4000
hwr328SPIMControlRateDiv32	equ	$6000
hwr328SPIMControlRateDiv64	equ	$8000
hwr328SPIMControlRateDiv128	equ	$A000
hwr328SPIMControlRateDiv256	equ	$C000
hwr328SPIMControlRateDiv512	equ	$E000
hwr328SPIMControlEnable		equ	$0200
hwr328SPIMControlExchange	equ	$0100
hwr328SPIMControlIntStatus	equ	$0080
hwr328SPIMControlIntEnable	equ	$0040
hwr328SPIMControlOppPhase	equ	$0020
hwr328SPIMControlInvPolarity	equ	$0010
hwr328SPIMControlBitsMask	equ	$000F

hwr328PortCMOClk	equ	$01
hwr328PortCUDS		equ	$02
hwr328PortCLDS		equ	$04
hwr328PortCNMI		equ	$10
hwr328PortCDTack	equ	$20
hwr328PortCPcmciaWE	equ	$40

hwr328PortGUartTxD	equ	$01
hwr328PortGUartRxD	equ	$02
hwr328PortGPwmOut	equ	$04
hwr328PortGTOut2	equ	$08
hwr328PortGTIn2		equ	$10
hwr328PortGTOut1	equ	$20
hwr328PortGTIn1		equ	$40
hwr328PortGRtcOut	equ	$80

hwr328PortKSpimTxD	equ	$01
hwr328PortKSpimRxD	equ	$02
hwr328PortKSpimClkO	equ	$04
hwr328PortKSpisEn	equ	$08
hwr328PortKSpisRxD	equ	$10
hwr328PortKSpisClkI	equ	$20
hwr328PortKPcmciaCE2	equ	$40
hwr328PortKPcmciaCE1	equ	$80

hwr328PortMCTS		equ	$01
hwr328PortMRTS		equ	$02
hwr328PortMIRQ6		equ	$04
hwr328PortMIRQ3		equ	$08
hwr328PortMIRQ2		equ	$10
hwr328PortMIRQ1		equ	$20
hwr328PortMPenIRQ	equ	$40
hwr328PortMUnused7	equ	$80


; Hardware\M68681Hwr.h

struct read
	mra.b
	u0.b
	sra.b
	u2.b
	doNotAccess1.b
	u4.b
	rba.b
	u6.b
	ipcr.b
	u8.b
	isr.b
	uA.b
	cur.b
	uC.b
	clr.b
	uE.b
	mrb.b
	u10.b
	srb.b
	u12.b
	doNotAccess2.b
	u14.b
	rbb.b
	u16.b
	ivr.w
	u18.b
	ipr.b
	u1A.b
	startCtr.b
	u1C.b
	stopCtr.b
	u1E.b
endstruct

struct write
	mra.b
	u0.b
	csra.b
	u2.b
	cra.b
	u4.b
	tba.b
	u6.b
	acr.b
	u8.b
	imr.w
	uA.b
	ctur.b
	uC.b
	ctlr.b
	uE.b
	mrb.b
	u10.b
	csrb.b
	u12.b
	crb.b
	u14.b
	tbb.b
	u16.b
	ivr.w
	u18.b
	opcr.b
	u1A.b
	opSet.b
	u1C.b
	opReset.b
	u1E.b
endstruct

hwrDuartSRRegRB		equ	$80
hwrDuartSRRegFE		equ	$40
hwrDuartSRRegPE		equ	$20
hwrDuartSRRegOE		equ	$10
hwrDuartSRRegTxEMP	equ	$08
hwrDuartSRRegTxRDY	equ	$04
hwrDuartSRRegFFULL	equ	$02
hwrDuartSRRegRxRDY	equ	$01


; Hardware\HardwareTD1.h

hwrTD1PortDNoExtPower	equ	$80
hwrTD1PortENoBacklight	equ	$80
hwrTD1PortFPanelYPOff	equ	$01
hwrTD1PortFPanelYMOn	equ	$02
hwrTD1PortFPanelXPOff	equ	$04
hwrTD1PortFPanelXMOn	equ	$08
hwrTD1PortFLCDEnableOn	equ	$10
hwrTD1PortFLCDVccOff	equ	$20
hwrTD1PortFLCDVeeOn	equ	$40
hwrTD1PortFADCSOff	equ	$80
hwrTD1PortFPanelMask	equ	$0F
hwrTD1PortFPanelCfgOff	equ	hwrTD1PortFPanelYPOff | hwrTD1PortFPanelXPOff
hwrTD1PortFPanelCfgPenIRQ	equ	hwrTD1PortFPanelXMOn | hwrTD1PortFPanelYPOff | hwrTD1PortFPanelXPOff
hwrTD1PortFPanelCfgYMeas	equ	hwrTD1PortFPanelXMOn | hwrTD1PortFPanelYPOff
hwrTD1PortFPanelCfgXMeas	equ	hwrTD1PortFPanelXPOff | hwrTD1PortFPanelYMOn
hwrTD1PortGSerialOn	equ	$08
hwrTD1PortGBattOff	equ	$10
hwrTD1PortGRefreshOut	equ	$20
hwrTD1PortGSelfRefOff	equ	$40
hwrTD1PortGSelfRefOffBit	equ	6
hwrTD1PortGBacklightOn	equ	$80
hwrTD1PortJIrOn		equ	$10
hwrTD1PortJLedOn	equ	$20
hwrTD1PortMVccFail	equ	$04
hwrTD1PortMCardIRQ	equ	$08
hwrTD1PortMUnused4	equ	$10
hwrTD1PortMDockButton	equ	$20
hwrTD1PortMPenIO	equ	$40
hwrTD1PortMDockIn	equ	$80
hwrTD1SPIMBaseControl	equ	hwr328SPIMControlRateDiv16 | hwr328SPIMControlIntEnable | hwr328SPIMControlInvPolarity | hwr328SPIMControlOppPhase | 16-1

hwrTD1PLLControl	equ	hwr328PLLControlClkEn | hwr328PLLControlSysVCODiv1 | hwr328PLLControlPixVCODiv1
hwrTD1FreqSelQ		equ	$01
hwrTD1FreqSelP		equ	$23
hwrTD1Frequency		equ	32768*((hwrTD1FreqSelP+1)*14+hwrTD1FreqSelQ+1)/1


; Hardware\Hardware.h

hwrWakeUpGeneral	equ	$0001
hwrWakeUpPWM		equ	$0002
hwrWakeUpFromKey	equ	$0004
hwrWakeUpReturnToSleep	equ	$0008

hwrMiscFlagHasBacklight	equ	$0001
hwrMiscFlagHasMbdIrDA	equ	$0002
hwrMiscFlagHasCardIrDA	equ	$0004
hwrMiscFlagHasBurrBrown	equ	$0008
hwrMiscFlagHasJerryHW	equ	$0010

hwrMiscFlagID1	equ	$1000
hwrMiscFlagID2	equ	$2000
hwrMiscFlagID3	equ	$4000
hwrMiscFlagID4	equ	$8000
hwrMiscFlagIDMask	equ	$F000

hwrDockInSyncButton	equ	$0001
hwrDockInGeneric1	equ	$0002

hwrDockOutGeneric0	equ	$0001

hwrNumCardSlots		equ	1

hwrDisplayWidth		equ	160
hwrDisplayHeight	equ	160

hwrDisplayBootDepth	equ	1
hwrDisplayMaxDepth	equ	2
hwrDisplayAllDepths	equ	$0003

hwrDisplayPeriod	equ	12

hwrStepsPerVolt		equ	78
hwrVoltStepsOffset	equ	0

hwrSystemTop		equ	(hwrDisplayHeight+4)
hwrSystemHeight		equ	56

hwrGraffitiTop		equ	hwrSystemTop
hwrGraffitiLeft		equ	27
hwrGraffitiWidth	equ	106
hwrGraffitiHeight	equ	hwrSystemHeight
hwrGraffitiSplit	equ	hwrGraffitiLeft+62

hwrLaunchBtnLeft	equ	0
hwrLaunchBtnTop		equ	hwrSystemTop
hwrLaunchBtnWidth	equ	27
hwrLaunchBtnHeight	equ	hwrSystemHeight/2

hwrMenuBtnWidth		equ	27
hwrMenuBtnHeight	equ	hwrSystemHeight/2
hwrMenuBtnLeft		equ	0
hwrMenuBtnTop		equ	hwrSystemTop+hwrMenuBtnHeight

hwrCalcBtnLeft		equ	133
hwrCalcBtnTop		equ	hwrSystemTop
hwrCalcBtnWidth		equ	27
hwrCalcBtnHeight	equ	hwrSystemHeight/2

hwrFindBtnLeft		equ	133
hwrFindBtnTop		equ	hwrSystemTop+hwrCalcBtnHeight
hwrFindBtnWidth		equ	27
hwrFindBtnHeight	equ	hwrSystemHeight/2

hwrKeyboardAlphaBtnLeft	equ	27
hwrKeyboardAlphaBtnTop	equ	(hwrSystemTop+hwrSystemHeight-hwrSystemHeight/4)
hwrKeyboardAlphaBtnWidth	equ	18
hwrKeyboardAlphaBtnHeight	equ	(hwrSystemHeight/4)

hwrKeyboardNumericBtnWidth	equ	18
hwrKeyboardNumericBtnHeight	equ	hwrKeyboardAlphaBtnHeight
hwrKeyboardNumericBtnLeft	equ	hwrFindBtnLeft-hwrKeyboardNumericBtnWidth
hwrKeyboardNumericBtnTop	equ	hwrKeyboardAlphaBtnTop

hwrLCDGetCurrentDepth	equ	0

struct HwrROMTokenRec
	token.l
	len.w
	data.b
endstruct

hwrROMTokenSnum	equ	'snum'
hwrROMTokenIrda	equ	'irda'
hwrROMTokenFlex	equ	'flex'
hwrROMTokenBoot1	equ	'cd01'
hwrROMTokenBoot2	equ	'cd02'
hwrROMTokenBoot3	equ	'cd03'


; Hardware\HardwarePrv.h

hwr68328Base	equ	$FFFFF000

hwrCardBase0	equ	$10000000
hwrCardSize	equ	$10000000
hwrFlashBase	equ	$10C00000
hwrFlashSize	equ	$00100000
hwrCardOffsetMask	equ	$0FFFFFFF

hwrROMWidth	equ	2

hwrDuartBase	equ	$10E00000
hwrDuartClock	equ	3686400
hwrDuartACRReg	equ	$60


; System\AlarmMgr.h

almErrMemory	equ	almErrorClass | 1
almErrFull	equ	almErrorClass | 2

struct SysAlarmTriggeredParamType
	ref.l
	alarmSeconds.l
	purgeAlarm.b
	pad.b
endstruct

struct SysDisplayAlarmParamType
	ref.l
	alarmSeconds.l
	soundAlarm.b
	pad.b
endstruct


; System\AlarmPrv.h

almMinTableLength	equ	2
almMaxTableLength	equ	20

struct AlmEntryType
	ref.l
	alarmSeconds.l
	dbID.l
	cardNo.w
	quiet.w
	triggered.w
	notified.w
endstruct

struct AlmTableType
	numEntries.w
	list.20
endstruct

struct AlmGlobalsType
	tableH.l
	lastSoundSeconds.l
	displaying.w
	triggered.w
	disableCount.b
	pad.b
endstruct


; System\AppLaunchCmd.h

; AddressLookupFields;
addrLookupName	equ	0
addrLookupFirstName	equ	1
addrLookupCompany	equ	2
addrLookupAddress	equ	3
addrLookupCity	equ	4
addrLookupState	equ	5
addrLookupZipCode	equ	6
addrLookupCountry	equ	7
addrLookupTitle	equ	8
addrLookupCustom1	equ	9
addrLookupCustom2	equ	10
addrLookupCustom3	equ	11
addrLookupCustom4	equ	12
addrLookupNote	equ	13
addrLookupWork	equ	14
addrLookupHome	equ	15
addrLookupFax	equ	16
addrLookupOther	equ	17
addrLookupEmail	equ	18
addrLookupMain	equ	19
addrLookupPager	equ	20
addrLookupMobile	equ	21
addrLookupSortField	equ	22
addrLookupListPhone	equ	23
addrLookupNoField	equ	$ff

addrLookupStringLength	equ	12

struct AddrLookupParamsType
	title.l
	pasteButtonText.l
	lookupString.12
	field1.b
	field2.b
	field2Optional.b
	userShouldInteract.b
	formatStringP.l
	resultStringH.l
	uniqueID.l
endstruct

;prefAppLaunchCmdSetActivePanel	equ	sysAppaunchCmdCustomBase + 1

struct PrefActivePanelParamsType
	activePanel.l
endstruct


; MailMsgPriorityType
mailPriorityHigh	equ	0
mailPriorityNormal	equ	1
mailPriorityLow	equ	2

struct MailAddRecordParamsType
	secret.b
	signature.b
	confirmRead.b
	confirmDelivery.b
	priority.b
	pad.b
	subject.l
	from.l
	to.l
	cc.l
	bcc.l
	replyTo.l
	body.l
endstruct


; System\CMClient.h

cmErrParam	equ	cmpErrorClass | 1
cmErrTimeOut	equ	cmpErrorClass | 2
cmErrComm	equ	cmpErrorClass | 3
cmErrCommVersion	equ	cmpErrorClass | 4
cmErrMemory	equ	cmpErrorClass | 5
cmErrCommBusy	equ	cmpErrorClass | 6
cmErrUserCan	equ	cmpErrorClass | 7

cmWakeupTransactionID	equ	$FF

struct CmParamType
	localSocket.w
	remoteSocket.w
	maxBaud.l
	viaModem.b
	abortProc.l
	userRef.l
endstruct

struct CmSessionType
	param.CmParamType
	serRefNum.w
endstruct


; System\CMCommon.h

; CmpType
cmpWakeup	equ	1
cmpInit		equ	2
cmpAbort	equ	3
cmpExtended	equ	4

struct CmpBodyType
	type.b
	flags.b
	verMajor.b
	verMinor.b
	wReserved.w
	commVersion.l
	baudRate.l
endstruct

cmpInitFlagChangeBaudRate	equ	$80
cmpInitFlagRcvTOut1Min	equ	$40
cmpInitFlagRcvTOut2Min	equ	$20

cmpAbortFlagVersionError	equ	$80

cmpWakeupTransactionID	equ	$FF

cmpInitialBaudRate	equ	9600

cmpMaxInitiateSec	equ	20

struct CmpCommandHeaderType
	hdrType.b
	cmd.b
	errorCode.w
	argCount.b
	reserved1.b
	reserved2.l
endstruct

;???typedef union CmpGenericCommandType {
;???	Byte						hdrType;	;	;
;???	;CmpBodyType				body10;
;???	;CmpCommandHeaderType	exHdr;
;???	;} CmpGenericCommandType;
;???	;
;???type def CmpGenericCommandType*		CmpGenericCommandPtr;

cmpRespBit	equ	$80

cmpCmdIDMask	equ	$7f

cmpFirstArgID	equ	$20

; CmpRespErrEnum
cmpRespErrNone	equ	0
cmpRespErrSystem	equ	1
cmpRespErrUnknownCmd	equ	2
cmpRespErrMemory	equ	3
cmpRespErrParam	equ	4
cmpRespErrLast	equ	5

; CmpCmdEnum
cmpCmdReserved	equ	$0F
cmpCmdXCommPrefs	equ	$10
cmpCmdHShakeComplete	equ	$11
cmpCmdLast	equ	$12

struct CmpCommPrefsType
	maxPktDataSize.l
	maxDataBlkSize.l
	maxBaudRate.l
	hwHShakeAbove.l
	flags.l
	version.l
	reserved2.l
	reserved3.l
endstruct

cmpCommPrefsFlagSupportPktCRC16	equ	$80000000
cmpCommPrefsFlagUsePktCRC16	equ	$00008000

cmpCommPrefsFlagSupportShortOffsets	equ	$40000000
cmpCommPrefsFlagUseShortOffsets		equ	$00004000
cmpCommPrefsFlagSupportLongOffsets	equ	$20000000
cmpCommPrefsFlagUseLongOffsets		equ	$00002000

cmpXCommPrefsReqArgID	equ	cmpFirstArgID

struct CmpXCommPrefsReqType
	prefs.CmpCommPrefsType
endstruct

cmpXCommPrefsPrefsRespArgID	equ	cmpFirstArgID
;???	cmpXCommPrefsIPAddrRespArgID	equ	cmpFirstArgID + 1

struct CmpXCommPrefsPrefsRespType
	prefs.CmpCommPrefsType
endstruct

struct CmpXCommPrefsIPAddrRespType
	ipAddr.b
endstruct

cmpHShakeCompleteReqArgID	equ	cmpFirstArgID

struct CmpHShakeCompleteReqType
	final.CmpCommPrefsType
endstruct CmpHShakeCompleteReqTypeCmpHShakeCompleteReqType


; System\CTP.h

; CTPCmdEnum
ctpCmdReqURL	equ	0
ctpCmdReqMail	equ	1
ctpCmdEcho	equ	2
ctpCmdMsgGen	equ	3
ctpCmdDiscard	equ	4

; ctpConvEnum
ctpConvCML	equ	0
ctpConvCML8Bit	equ	1
ctpConvCMLLZSS	equ	2
ctpConvNone	equ	3

; CTPReqExtEnum
ctpExtIncHTTPResponse	equ	1
ctpExtNetID	equ	128
ctpExtUserID	equ	129
ctpExtUserPW	equ	130
ctpExtUserName	equ	131
ctpExtServer	equ	132
ctpExtConvertTo	equ	133

; CTPRspExtURLEnum
ctpExtContentType	equ	128
ctpExtContentEncoding	equ	129
ctpExtUncompressSize	equ	130

; CTPNetIDEnum
ctpNetIDMobitex	equ	0
ctpNetIDUnknown	equ	$FFFF

; CTPSchemeEnum
ctpSchemeHTTP	equ	0
ctpSchemeHTTPS	equ	1
ctpSchemeFTP	equ	2
ctpSchemeEmpty	equ	7

; CTPErrEnum
ctpErrNone	equ	0
ctpErrMalformedRequest	equ	1
ctpErrUnknownCmd	equ	2
ctpErrProxy	equ	3
ctpErrServer	equ	4
ctpErrTruncated	equ	$8000


; System\DataMgr.h

dmRecAttrCategoryMask	equ	$0F
dmRecNumCategories	equ	16
dmCategoryLength	equ	16

dmAllCategories	equ	$ff
dmUnfiledCategory	equ	0

dmMaxRecordIndex	equ	$ffff

dmRecAttrDelete	equ	$80
dmRecAttrDirty	equ	$40
dmRecAttrBusy	equ	$20
dmRecAttrSecret	equ	$10

dmAllRecAttrs	equ	dmRecAttrDelete|dmRecAttrDirty|dmRecAttrBusy|dmRecAttrSecret

dmSysOnlyRecAttrs	equ	dmRecAttrBusy

dmDBNameLength	equ	32

dmHdrAttrResDB	equ	$0001
dmHdrAttrReadOnly	equ	$0002
dmHdrAttrAppInfoDirty	equ	$0004
dmHdrAttrBackup	equ	$0008
dmHdrAttrOKToInstallNewer	equ	$0010
dmHdrAttrResetAfterInstall	equ	$0020
dmHdrAttrCopyPrevention	equ	$0040
dmHdrAttrStream	equ	$0080
dmHdrAttrOpen	equ	$8000

dmAllHdrAttrs	equ	dmHdrAttrResDB | dmHdrAttrReadOnly | dmHdrAttrAppInfoDirty | dmHdrAttrBackup | dmHdrAttrOKToInstallNewer | dmHdrAttrResetAfterInstall | dmHdrAttrCopyPrevention | dmHdrAttrStream | dmHdrAttrOpen)

dmSysOnlyHdrAttrs	equ	dmHdrAttrResDB | dmHdrAttrOpen)

dmRecordIDReservedRange	equ	1

dmDefaultRecordsID	equ	0

dmUnusedRecordID	equ	0

dmModeReadOnly	equ	$0001
dmModeWrite	equ	$0002
dmModeReadWrite	equ	$0003
dmModeLeaveOpen	equ	$0004
dmModeExclusive	equ	$0008
dmModeShowSecret	equ	$0010

struct DmSearchStateType
	info.32
endstruct

struct SortRecordInfoType
	attributes.b
	uniqueID.3
endstruct

dmErrMemError			equ	dmErrorClass | 1
dmErrIndexOutOfRange		equ	dmErrorClass | 2
dmErrInvalidParam		equ	dmErrorClass | 3
dmErrReadOnly			equ	dmErrorClass | 4
dmErrDatabaseOpen		equ	dmErrorClass | 5
dmErrCantOpen			equ	dmErrorClass | 6
dmErrCantFind			equ	dmErrorClass | 7
dmErrRecordInWrongCard		equ	dmErrorClass | 8
dmErrCorruptDatabase		equ	dmErrorClass | 9
dmErrRecordDeleted		equ	dmErrorClass | 10
dmErrRecordArchived		equ	dmErrorClass | 11
dmErrNotRecordDB		equ	dmErrorClass | 12
dmErrNotResourceDB		equ	dmErrorClass | 13
dmErrROMBased			equ	dmErrorClass | 14
dmErrRecordBusy			equ	dmErrorClass | 15
dmErrResourceNotFound		equ	dmErrorClass | 16
dmErrNoOpenDatabase		equ	dmErrorClass | 17
dmErrInvalidCategory		equ	dmErrorClass | 18
dmErrNotValidRecord		equ	dmErrorClass | 19
dmErrWriteOutOfBounds		equ	dmErrorClass | 20
dmErrSeekFailed			equ	dmErrorClass | 21
dmErrAlreadyOpenForWrites	equ	dmErrorClass | 22
dmErrOpenedByAnotherTask	equ	dmErrorClass | 23
dmErrUniqueIDNotFound		equ	dmErrorClass | 24
dmErrAlreadyExists		equ	dmErrorClass | 25
dmErrInvalidDatabaseName	equ	dmErrorClass | 26
dmErrDatabaseProtected		equ	dmErrorClass | 27

dmSeekForward	equ	1
dmSeekBackward	equ	-1


; System\DataPrv.h

struct RecordEntryType
	localChunkID.l
	attributes.b
	uniqueID.3
endstruct

struct RsrcEntryType
	type.l
	id.w
	localChunkID.l
endstruct

dmRsrcAttrUnused	equ	$0000

struct RecordListType
	nextRecordListID.l
	numRecords.w
	firstEntry.w
endstruct

struct DatabaseHdrType
	name.32
	attributes.w
	version.w
	creationDate.l
	modificationDate.l
	lastBackupDate.l
	modificationNumber.l
	appInfoID.l
	sortInfoID.l
	type.l
	creator.l
	uniqueIDSeed.l
	recordList.RecordListType
endstruct

struct DatabaseDirType
	nextDatabaseListID.l
	numDatabases.w
	databaseID.l
endstruct

struct DmOpenInfoType
	next.l
	openCount.w
	ownerTaskID.l
	exclusive.w
	writeAccess.w
	resDB.w
	hdrID.l
	hdrH.l
	hdrP.l
	cardNo.w
	numRecords.w
	hdrMasterP.l
	handleTableP.l
endstruct

struct DmAccessType
	next.l
	mode.w
	openP.l
	savedModNum.l
endstruct

struct DmPrvSearchStateType
	index.w
	relIndex.w
	cardNo.b
	storeNo.b
	storeEntries.w
	storeStartIndex.w
	dirID.l
endstruct

struct DmProtectEntryType
	protectCount.b
	cardNo.b
	dbID.l
endstruct

dmDynOwnerID	equ	$00
dmMgrOwnerID	equ	$01
dmRecOwnerID	equ	$02
dmOrphanOwnerID	equ	$03


; System\DateTime.h

struct DateTimeType
	second.w
	minute.w
	hour.w
	day.w
	month.w
	year.w
	weekDay.w
endstruct

struct TimeType
	hours.b
	minutes.b
endstruct

noTime	equ	-1

struct DateType
	year.w
	month.w
	day.w
endstruct

timeStringLength	equ	9
dateStringLength	equ	9
longDateStrLength	equ	15

firstYear	equ	1904
numberOfYears	equ	128
lastYear	equ	firstYear + numberOfYears - 1

minutesInSeconds	equ	60
hoursInMinutes	equ	60
hoursInSeconds	equ	hoursInMinutes * minutesInSeconds
hoursPerDay	equ	24

daysInSeconds	equ	$15180

daysInWeek	equ	7
daysInYear	equ	365
daysInLeapYear	equ	366
daysInFourYears	equ	daysInLeapYear + 3 * daysInYear

monthsInYear	equ	12

maxDays	equ	numberOfYears / 4 * daysInFourYears - 1
maxSeconds	equ	maxDays * daysInSeconds
maxTime	equ	$0

sunday	equ	0
monday	equ	1
tuesday	equ	2
wednesday	equ	3
thursday	equ	4
friday	equ	5
saturday	equ	6

january	equ	1
february	equ	2
march	equ	3
april	equ	4
may	equ	5
june	equ	6
july	equ	7
august	equ	8
september	equ	9
october	equ	10
november	equ	11
december	equ	12

; DayOfWeekType
dom1stSun	equ	0
dom1stMon	equ	1
dom1stTue	equ	2
dom1stWen	equ	3
dom1stThu	equ	4
dom1stFri	equ	5
dom1stSat	equ	6
dom2ndSun	equ	7
dom2ndMon	equ	8
dom2ndTue	equ	9
dom2ndWen	equ	10
dom2ndThu	equ	11
dom2ndFri	equ	12
dom2ndSat	equ	13
dom3rdSun	equ	14
dom3rdMon	equ	15
dom3rdTue	equ	16
dom3rdWen	equ	17
dom3rdThu	equ	18
dom3rdFri	equ	19
dom3rdSat	equ	20
dom4thSun	equ	21
dom4thMon	equ	22
dom4thTue	equ	23
dom4thWen	equ	24
dom4thThu	equ	25
dom4thFri	equ	26
dom4thSat	equ	27
domLastSun	equ	28
domLastMon	equ	29
domLastTue	equ	30
domLastWen	equ	31
domLastThu	equ	32
domLastFri	equ	33
domLastSat	equ	34


; System\DebugMgr.h

dbgCtlNotHandled	equ	false
dbgCtlHandled		equ	true
dbgCtlAllHandlersID	equ	0
dbgCtlHandlerNameLen	equ	31
dbgCtlHandlerVerLen	equ	15
dbgCtlFirstCustomOp	equ	$8000

struct DbgCtlHandlerInfoType
	handlerFuncP.l
	version.l
	enabled.b
	pad.b
	name.32
	ver.16
	dwReserved.l
endstruct

struct DbgCtlEnumInfoType
	enumFuncP.l
	callbackDataP.l
endstruct

dbgCtlOpEnumHandlers	equ	1
dbgCtlOpGetHandlerInfo	equ	2
dbgCtlOpEnableHandler	equ	3
dbgCtlOpDisableHandler	equ	4
dbgCtlOpGetEnabledStatus	equ	5
dbgCtlOpGetVersion	equ	6
dbgCtlOpLAST	equ	7


; System\ExgMgr.h

exgMemError		equ	exgErrorClass | 1
exgErrStackInit		equ	exgErrorClass | 2
exgErrUserCancel	equ	exgErrorClass | 3
exgErrNoReceiver	equ	exgErrorClass | 4
exgErrNoKnownTarget	equ	exgErrorClass | 5
exgErrTargetMissing	equ	exgErrorClass | 6
exgErrNotAllowed	equ	exgErrorClass | 7
exgErrBadData		equ	exgErrorClass | 8
exgErrAppError		equ	exgErrorClass | 9
exgErrUnknown		equ	exgErrorClass | 10
exgErrDeviceFull	equ	exgErrorClass | 11
exgErrDisconnected	equ	exgErrorClass | 12
exgErrNotFound		equ	exgErrorClass | 13
exgErrBadParam		equ	exgErrorClass | 14
exgErrNotSupported	equ	exgErrorClass | 15
exgErrDeviceBusy	equ	exgErrorClass | 16
exgErrBadLibrary	equ	exgErrorClass | 17

struct ExgGoToType
	dbCardNo.w
	dbID.l
	recordNum.w
	uniqueID.l
	matchCustom.l
endstruct

struct ExgSocketType
	libraryRef.w
	socketRef.l
	target.l
	count.l
	length.l
	time.l
	appData.l
	goToCreator.l
	goToParams.ExgGoToType
	flags.w
	description.l
	type.l
	name.l
endstruct
;	localMode:1.w
;	packetMode:1.w
;	reserved:14.w

struct ExgAskParamType
	socketP.l
	result.w	;exgAskResultType
endstruct

exgSeparatorChar	equ	'\t'

exgRegLibraryID		equ	$fffc
exgRegExtensionID	equ	$fffd
exgRegTypeID		equ	$fffe

exgDataPrefVersion	equ	0
exgMaxTitleLen		equ	20

exgLibCtlGetTitle	equ	1
exgLibCtlSpecificOp	equ	$8000


; System\ErrorMgr.h

struct ErrExceptionType
	nextP.l
	state.48
	err.l
endstruct


; System\ExgLib.h

exgIntDataChr	equ	$01ff

; ExgLibTrapNumberEnum
exgLibTrapHandleEvent	equ	sysLibTrapCustom
exgLibTrapConnect	equ	sysLibTrapCustom+1
exgLibTrapAccept	equ	sysLibTrapCustom+2
exgLibTrapDisconnect	equ	sysLibTrapCustom+3
exgLibTrapPut		equ	sysLibTrapCustom+4
exgLibTrapGet		equ	sysLibTrapCustom+5
exgLibTrapSend		equ	sysLibTrapCustom+6
exgLibTrapReceive	equ	sysLibTrapCustom+7
exgLibTrapControl	equ	sysLibTrapCustom+8
exgLibReserved1		equ	sysLibTrapCustom+9
exgLibTrapLast		equ	sysLibTrapCustom+10


; System\FeatureMgr.h

ftrErrInvalidParam	equ	ftrErrorClass | 1
ftrErrNoSuchFeature	equ	ftrErrorClass | 2
ftrErrAlreadyExists	equ	ftrErrorClass | 3
ftrErrROMBased		equ	ftrErrorClass | 4
ftrErrInternalErr	equ	ftrErrorClass | 5


; System\FeaturePrv.h

struct FtrFeatureType
	num.w
	value.l
endstruct

struct FtrCreatorType
	creator.l
	numEntries.w
	feature.FtrFeatureType
endstruct

struct FtrTableType
	numEntries.w
	creator.FtrCreatorType
endstruct

struct FtrGlobalsType
	romTableH.l
	ramTableH.l
endstruct

struct FtrCacheType
	romTableH.l
	ramTableH.l
	romTableP.l
	ramTableP.l
endstruct


; System\FileStream.h

fileErrMemError			equ	fileErrorClass | 1
fileErrInvalidParam		equ	fileErrorClass | 2
fileErrCorruptFile		equ	fileErrorClass | 3
fileErrNotFound			equ	fileErrorClass | 4
fileErrTypeCreatorMismatch	equ	fileErrorClass | 5
fileErrReplaceError		equ	fileErrorClass | 6
fileErrCreateError		equ	fileErrorClass | 7
fileErrOpenError		equ	fileErrorClass | 8
fileErrInUse			equ	fileErrorClass | 9
fileErrReadOnly			equ	fileErrorClass | 10
fileErrInvalidDescriptor	equ	fileErrorClass | 11
fileErrCloseError		equ	fileErrorClass | 12
fileErrOutOfBounds		equ	fileErrorClass | 13
fileErrPermissionDenied		equ	fileErrorClass | 14
fileErrIOError			equ	fileErrorClass | 15
fileErrEOF			equ	fileErrorClass | 16
fileErrNotStream		equ	fileErrorClass | 17

fileNullHandle	equ	0

fileModeReadOnly	equ	$80000000
fileModeReadWrite	equ	$40000000
fileModeUpdate		equ	$20000000
fileModeAppend		equ	$10000000

fileModeLeaveOpen	equ	$08000000
fileModeExclusive	equ	$04000000
fileModeAnyTypeCreator	equ	$02000000

fileModeTemporary	equ	$01000000

fileModeDontOverwrite	equ	$00800000

fileModeAllFlags	equ	fileModeReadOnly | fileModeReadWrite | fileModeUpdate | fileModeAppend | fileModeLeaveOpen | fileModeExclusive | fileModeAnyTypeCreator | fileModeTemporary | fileModeDontOverwrite

; FileOriginEnum
fileOriginBeginning	equ	1
fileOriginCurrent	equ	2
fileOriginEnd	equ	3

; FileOpEnum
fileOpNone	equ	0
fileOpDestructiveReadMode	equ	1
fileOpGetEOFStatus	equ	2
fileOpGetLastError	equ	3
fileOpClearError	equ	4
fileOpGetIOErrorStatus	equ	5
fileOpGetCreatedStatus	equ	6
fileOpGetOpenDbRef	equ	7
fileOpFlush	equ	8
fileOpLAST	equ	9


; System\FileStreamPrv.h

fileDescriptorSignature	equ	'STRM'
fileStateOpenComplete	equ	($8000)
fileStateWriteAccess	equ	($4000)
fileStateDestructiveRead	equ	($2000)
fileStateAppend		equ	($1000)
fileStateCreated	equ	($0800)
fileStateCompressed	equ	($0400)
fileStateIOError	equ	($0001)
fileStateEOF		equ	($0002)


fileAllStates	equ	fileStateOpenComplete | fileStateWriteAccess | fileStateDestructiveRead | fileStateAppend | fileStateCreated | fileStateCompressed | fileStateIOError | fileStateEOF

struct FileCachedInfoType
	blockH.l
	blockIndex.l
	forWrite.b
	bReserved.b
endstruct

struct FileDescriptorType
	sig.l
	openMode.l
	state.w
	dbR.l
	lastError.w
	fileSize.l
	numBlocks.l
	curOffset.l
	cached.FileCachedInfoType
	dwReserved1.l
	dwReserved2.l
endstruct

fileBlockDataSize	equ	1024 * 4

fileDataBlockSignature	equ	'DBLK'
fileDataBlockCategory	equ	dmUnfiledCategory

struct FileBlockHeaderType
	sig.l
	dataSize.l
endstruct

struct FileDataBlockType
	hdr.FileBlockHeaderType
	data.4096
endstruct


; System\FloatMgr.h

fMaxLong	equ	($7FFFFFFF)
fMinLong	equ	($80000000)

struct FloatTypeFloatType
	man.l
	exp.w
	sign.b
	pad.b
endstruct

kExpInf	equ	16000

fplErrOutOfRange	equ	fplErrorClass | 1


; System\Globals.h

sysUIRsvGlobalsSize equ $000000a0

struct FixedGlobalsType
	memCardSlots.b
	dbgWasEntered.b
	memCardInfoP.l
	memSemaphoreID.l
	memDebugMode.w
	dmOpenList.l
	dbgInDebugger.b
	dbgTracing.b
	dbgGlobalsP.l
	dbgSerGlobalsP.l
	sysAppInfoP.l
	sysKernelDataP.l
	sysDispatchTableP.l
	sysOwnerIDsInUse.l
	sysAMXAppInfoP.l
	sysClockFreq.l
	sysHardKeyCreators.l
	sysBatteryCheckTimer.w
	sysBatteryMinThreshold.b
	hwrBatteryLevel.b
	sysNextBatteryAlertTimer.w
	sysBatteryWarnThreshold.b
	sysDispatchTableRev.b
	sysDispatchTableSize.w
	sysLibTableP.l
	sysLibTableEntries.w
	sysConsoleStackChunkP.l
	sysUIShellAppInfoP.l
	sysTimerID.l
	sysAutoOffEvtTicks.l
	sysAutoOffSeconds.w
	sysRandomSeed.l
	slkGlobalsP.l
	serGlobalsP.l
	scrGlobalsP.l
	fplGlobalsP.l
	penGlobalsP.l
	sysEvtMgrGlobalsP.l
	sndGlobalsP.l
	timGlobalsP.l
	almGlobalsP.l
	ftrGlobalsP.l
	grfGlobalsP.l
	keyGlobalsP.l
	uiGlobals.160
	uiExtensionsP.l
	unusedPtr.l
	nextUIAppDBID.l
	nextUIAppCmd.w
	nextUIAppCmdPBP.l
	nextUIAppCardNo.b
	hwrDataWELevel.b
	hwrWakeUp.w
	hwrCPUDutyCycle.b
	hwrPenDown.b
	hwrCurTicks.l
	hwrTotalRAMSize.l
	hwrDozeSubTicks.l
	sndOffTicks.l
	sysResetFlags.b
	sysBatteryKind.b
	memMinDynHeapFree.l
	sysPrefFlags.w
	sysGlobalsP.l
	sysMiscFlags.w
	sysLibNet.w
	netPktFreeQ.l
	sysEvGroupID.l
	irq3GlobalsP.l
	sysLastBatteryWarning.l
	sysLowMemChecksum.l
	hwrHardwareRev.w
	Handle.l
	dmProtectListH.l
	hwrMiscFlags.w
	sysProfileRefcon.l
	sysProfileProcP.l
	flpSoftFPSCR.l
	irLibGlobalsP.l
	exgActiveLib.w
	uiBusyCount.w
	irq1GlobalsP.l
	irq2GlobalsP.l
	irq6GlobalsP.l
endstruct

struct LowMemHdrType
	vectors.M68KExcTableType
	globals.FixedGlobalsType
endstruct

PilotGlobalsP	equ	0


; System\Graffiti.h

grfNoShortCut	equ	$ffff

struct GrfMatchType
	glyphID.b
	unCertainty.b
endstruct

grfMaxMatches	equ	4

struct GrfMatchInfoType
	numMatches.w
	match.8
endstruct

grfNameLength	equ	8
grfVirtualSequence	equ	$01
grfShiftSequence	equ	$02
grfSpecialSequence	equ	$03
grfExpansionSequence	equ	'@'
expandDateChar	equ	'D'
expandTimeChar	equ	'T'
expandStampChar	equ	'S'

shortcutBinaryDataFlag	equ	$01

grfTempShiftPunctuation	equ	1
grfTempShiftExtended	equ	2
grfTempShiftUpper	equ	3
grfTempShiftLower	equ	4

grfErrBadParam		equ	grfErrorClass | 1
grfErrPointBufferFull	equ	grfErrorClass | 2
grfErrNoGlyphTable	equ	grfErrorClass | 3
grfErrNoDictionary	equ	grfErrorClass | 4
grfErrNoMapping	equ	grfErrorClass | 5
grfErrMacroNotFound	equ	grfErrorClass | 6
grfErrDepthTooDeep	equ	grfErrorClass | 7
grfErrMacroPtrTooSmall	equ	grfErrorClass | 8
grfErrNoMacros		equ	grfErrorClass | 9
grfErrMacroIncomplete	equ	grfErrorClass | 129
grfErrBranchNotFound	equ	grfErrorClass | 130


; System\GraffitiPrv.h

grfSpecialToggleSplitMode	equ	$01
grfSpecialNoAutoOff		equ	$02
grfSpecialShowUserInfo		equ	$03
grfSpecialDeleteUserInfo	equ	$04
grfSpecialSystemBuildDate	equ	$05
grfSpecialBatteryKind		equ	$06

grfMaxKeys	equ	100

grfMacrosResT	equ	'macr'
grfMacrosResID	equ	10000
grfMacrosMinSize	equ	10

grfMacrosDBVersion	equ	0

grfWarningOffset	equ	128

grfMaxMacroName	equ	32

;struct GrfGlobalsType
;	p3Data.TP3Data
;	state.TP3DictState
;	uncertain.w
;	glyphFlags.w
;	shiftState.w
;	macroNameLen.w
;	macroName.grfMaxMacroName
;	lastChar.b
;	pad.b
;	globalsSize.l
;	splitMode.w
;	restoreCaps.w
;	inMacro.w
;	wasAutoShifted.w
;	upShiftGlyphID.b
;	pad2.b
;	Handle.l
;	globalsH.l
;	Handle.l
;	templateH.l
;	Handle.l
;	dictH.l
;	Handle.l
;	macrosH.l
;	macrosDbP.l
;endstruct


; System\GraffitiReference.h

; ReferenceType
referenceAlpha	equ	0
referencePunc1	equ	1
referencePunc2	equ	2
referencePunc3	equ	3
referenceExtended	equ	4
referenceAccent	equ	5
referenceDefault	equ	$ff

referenceFirst	equ	referenceAlpha
referenceLast	equ	referenceAccent


; System\ImcUtils.h

EOF	equ	$ffff

parameterDelimeterChr	equ	';'
valueDelimeterChr	equ	':'
groupDelimeterChr	equ	'.'
paramaterNameDelimiterChr	equ	'='
endOfLineChr		equ	$0D

imcFilenameLength	equ	32
imcUnlimitedChars	equ	$FFFE


; System\irlib.h

;irLibName	equ	"IrDA Library"

;irFtrCreator	equ	sysFileCIrLib
irFtrNumVersion	equ	0

irOpenOptBackground	equ	$80000000
irOpenOptSpeed115200	equ	$0000003F
irOpenOptSpeed57600	equ	$0000001F
irOpenOptSpeed9600	equ	$00000003

;irGetScanningMode	equ	exgibCtlSpecificOp
;irSetScanningMode	equ	exgibCtlSpecificOp
;irGetStatistics	equ	exgibCtlSpecificOp
;irSetSerialMode	equ	exgibCtlSpecificOp
;irSetBaudMask	equ	exgibCtlSpecificOp
;irSetSupported	equ	exgibCtlSpecificOp

struct IrStatsType
	recLineErrors.w
	crcErrors.w
endstruct

;???	} IrLibTrapNumberEnum;
;???	irLibTrapBind = exgLibTrapLast
;???	irLibTrapUnBind,
;???	irLibTrapDiscoverReq,
;???	irLibTrapConnectIrLap,
;???	irLibTrapDisconnectIrLap,
;???	irLibTrapConnectReq,
;???	irLibTrapConnectRsp,
;???	irLibTrapDataReq,
;???	irLibTrapLocalBusy,
;???	irLibTrapMaxTxSize,
;???	irLibTrapMaxRxSize,
;???	irLibTrapSetDeviceInfo,
;???	irLibTrapIsNoProgress,
;???	irLibTrapIsRemoteBusy,
;???	irLibTrapIsMediaBusy,
;???	irLibTrapIsIrLapConnected,
;???	irLibTrapTestReq,
;???	irLibTrapIAS_Add,
;???	irLibTrapIAS_Query,
;???	irLibTrapIAS_SetDeviceName,
;???	irLibTrapIAS_Next,
;???	irLibTrapIrOpen,
;???	irLibTrapHandleEvent,
;???	irLibTrapWaitForEvent,
;???	irLibTrapLast

IR_MAX_CON_PACKET	equ	60
IR_MAX_TTP_CON_PACKET	equ	52
IR_MAX_TEST_PACKET	equ	376
IR_MAX_DEVICE_INFO	equ	23

IR_DEVICE_LIST_SIZE	equ	6

IR_MAX_XID_LEN	equ	23

IR_MAX_LSAP	equ	$6f

IR_HINT_PNP	equ	$01
IR_HINT_PDA	equ	$02
IR_HINT_COMPUTER	equ	$04
IR_HINT_PRINTER	equ	$08
IR_HINT_MODEM	equ	$10
IR_HINT_FAX	equ	$20
IR_HINT_LAN	equ	$40
IR_HINT_EXT	equ	$80

IR_HINT_TELEPHONY	equ	$01
IR_HINT_FILE	equ	$02
IR_HINT_IRCOMM	equ	$04
IR_HINT_MESSAGE	equ	$08
IR_HINT_HTTP	equ	$10
IR_HINT_OBEX	equ	$20

;???typedef Byte IrStatus;

;???typedef Byte IrCharSet;

IR_CHAR_ASCII	equ	0
IR_CHAR_ISO_8859_1	equ	1
IR_CHAR_ISO_8859_2	equ	2
IR_CHAR_ISO_8859_3	equ	3
IR_CHAR_ISO_8859_4	equ	4
IR_CHAR_ISO_8859_5	equ	5
IR_CHAR_ISO_8859_6	equ	6
IR_CHAR_ISO_8859_7	equ	7
IR_CHAR_ISO_8859_8	equ	8
IR_CHAR_ISO_8859_9	equ	9
IR_CHAR_UNICODE	equ	$ff

;???typedef Byte IrEvent;

LEVENT_LM_CON_IND	equ	0
LEVENT_LM_DISCON_IND	equ	1
LEVENT_DATA_IND	equ	2
LEVENT_PACKET_HANDLED	equ	3
LEVENT_LAP_CON_IND	equ	4
LEVENT_LAP_DISCON_IND	equ	5
LEVENT_DISCOVERY_CNF	equ	6
LEVENT_LAP_CON_CNF	equ	7
LEVENT_LM_CON_CNF	equ	8
LEVENT_STATUS_IND	equ	9
LEVENT_TEST_IND	equ	10
LEVENT_TEST_CNF	equ	11

LCON_FLAGS_TTP	equ	$02

IR_MAX_QUERY_LEN	equ	61

IR_MAX_IAS_NAME	equ	60
IR_MAX_ATTRIBUTES	equ	255

IR_MAX_IAS_ATTR_SIZE	equ	56

IAS_ATTRIB_MISSING	equ	0
IAS_ATTRIB_INTEGER	equ	1
IAS_ATTRIB_OCTET_STRING	equ	2
IAS_ATTRIB_USER_STRING	equ	3
IAS_ATTRIB_UNDEFINED	equ	$ff

IAS_GET_VALUE_BY_CLASS	equ	4

;struct IrPacket
;	node.ListEntry
;	buff.l
;	len.w
;	origin.l
;	headerLen.b
;	pad.b
;	header.14
;endstruct

;???typedef  union {
;???    Byte  u8[4];
;???    Word  u16[2];
;???    DWord u32;
;???} IrDeviceAddr;

struct IrDeviceInfo
	hDevice.l
	len.b
	xid.23
endstruct

;pstruct IrDeviceList
;	nItems.b
;	pad.b
; IrDeviceInfo  dev[IR_DEVICE_LIST_SIZE]; /* Fixed size in IrDA Lite */
;endstruct IrDeviceList

struct IrCallBackParms
	event.b
	pad.b
	rxBuff.l
	rxLen.w
	packet.l
	deviceList.l;  /* Pointer to discovery device list */
	status.w
endstruct

;struct _hconnect
;	lLsap.b
;	rLsap.b
;	flags.b
;	pad.b
;	callBack.l
;	packet.IrPacket
;	packets.ListEntry
;	sendCredit.w
;	availCredit.b
;	dataOff.b
;endstruct


struct _IrIasAttribute
	name.l
	len.b
	pad.b
	value.l
	valLen.b
endstruct

struct _IrIasObject
	name.l
	len.b
	nAttribs.b
	attribs.l
endstruct IrIasObjectIrIasObject

struct _IrIasQuery
	queryLen.b
	pad.b
	queryBuf.l
	resultBufSize.w
	resultLen.w
	listLen.w
	offset.w
	retCode.b
	overFlow.b
	result.l
endstruct


; System\KeyMgr.h

keyBitPower	equ	$01
keyBitPageUp	equ	$02
keyBitPageDown	equ	$04
keyBitHard1	equ	$08
keyBitHard2	equ	$10
keyBitHard3	equ	$20
keyBitHard4	equ	$40
keyBitCradle	equ	$80

keyBitsAll	equ	$FFFFFFFF

slowestKeyDelayRate	equ	$ff
slowestKeyPeriodRate	equ	$ff


; System\KeyPrv.h

;keyMinUpTicks	equ	sysTicksPerSecond/20

;keyMinBacklightTicks	equ	sysTicksPerSecond
keyBitMask	equ	$007F

struct KeyGlobalsType
	lastKeyTicks.l
	keyState.b
	keyStateMask.b
	keyUpCount.b
	initDelay.b
	period.b
	turnOnTicks.l
	doubleTapTicks.l
	doubleTapDelay.w
	doubleTapState.b
	Belongs.l
	queueAhead.b
endstruct


; System\Launcher.h

struct LauncherType
	form.l
	numItems.w
	columns.w
	rows.w
	topItem.w
	selection.b
	appInfoH.l
	timeFormat.w
	timeString.9
	pad.b
	savedForm.l
endstruct


; System\MemoryMgr.h

; LocalIDKind
memIDPtr	equ	0
memIDHandle	equ	1

memNewChunkFlagPreLock	equ	$0100
memNewChunkFlagNonMovable	equ	$0200
memNewChunkFlagAtStart	equ	$0400
memNewChunkFlagAtEnd	equ	$0800

memDebugModeCheckOnChange	equ	$0001
memDebugModeCheckOnAll	equ	$0002
memDebugModeScrambleOnChange	equ	$0004
memDebugModeScrambleOnAll	equ	$0008
memDebugModeFillFree	equ	$0010
memDebugModeAllHeaps	equ	$0020
memDebugModeRecordMinDynHeapFree	equ	$0040

memErrChunkLocked		equ	memErrorClass | 1
memErrNotEnoughSpace		equ	memErrorClass | 2
memErrChunkNotLocked		equ	memErrorClass | 4
memErrCardNotPresent		equ	memErrorClass | 5
memErrNoCardHeader		equ	memErrorClass | 6
memErrInvalidStoreHeader	equ	memErrorClass | 7
memErrRAMOnlyCard		equ	memErrorClass | 8
memErrWriteProtect		equ	memErrorClass | 9
memErrNoRAMOnCard		equ	memErrorClass | 10
memErrNoStore			equ	memErrorClass | 11


; System\MidiPrv.h

midiSmfHeaderChunkType	equ	'MThd'
midiSmfTrackChunkType	equ	'MTrk'

midiSmfFmt0	equ	0
midiSmfFmt1	equ	1
midiSmfFmt2	equ	2
midiSmfFmtUnknown	equ	$FFFF

midiSmfMaxValidFmt	equ	midiSmfFmt2

midiSmfNegSMPTEFmt24		equ	-24
midiSmfNegSMPTEFmt25		equ	-25
midiSmfNegSMPTEFmt30Drop	equ	-29
midiSmfNegSMPTEFmt30NonDrop	equ	-30

midiMsgStatusNone	equ	0
midiMaxChanMsgStatus	equ	$EF
midiMsgBaseNoteOff	equ	$080
midiMsgBaseNoteOn	equ	$090
midiMsgBasePolyPress	equ	$0A0
midiMsgBaseCtlChange	equ	$0B0
midiMsgBaseProgChange	equ	$0C0
midiMsgBaseChanPress	equ	$0D0
midiMsgBasePitchBend	equ	$0E0

midiSmfEvtStatusMeta	equ	$FF
midiSmfEvtStatusSysExF0	equ	$F0
midiSmfEvtStatusSysExF7	equ	$F7

midiSmfMetaEvtTypeEOT	equ	$2F
midiSmfMetaEvtTypeTempo	equ	$51

midiStatusBit		equ	$80
midiChanNumMask		equ	$0F
midiChanMsgMask		equ	$F0
midiSmfSMPTEDivBit	equ	$8000
midiSmfSMPTEDivTicksMask	equ	$00FF

midiMinChan	equ	0
midiMaxChan	equ	15

midiMinKey	equ	0
midiMaxKey	equ	127

midiMinVel	equ	0
midiMaxVel	equ	127

midiSmfMinHdrChunkDataSize	equ	6
midiSmfMinTrkChunkDataSize	equ	4

midiDefTempo	equ	500000
midiDefVel	equ	64

midiSmfHdrFmtBytes	equ	2
midiSmfHdrTrkBytes	equ	2
midiSmfHdrDivBytes	equ	2
midiSmfChunkTypeBytes	equ	4
midiSmfChunkLengthBytes	equ	4
midiSmfTempoBytes	equ	3

struct MidiSmfHdrInfoType
	wFmt.w
	wNumTracks.w
	wDivRaw.w
	bUsingSMPTE.b
	pad.b
	wTicksPerQN.w
	dwTicksPerSec.l
endstruct

struct MidiStateType
	hdr.MidiSmfHdrInfoType
	streamP.l
	chunkEndP.l
	dwChunkType.l
	dwChunkSize.l
	bMsgStatus.b
	pad.b
	dwTempo.l
	bFirstChan.b
	bLastChan.b
endstruct

;???typedef enum MidiSmfEvtClassEnum {
;???	eMidiSmfEvtClassUnknown = 0,
;???	eMidiSmfEvtClassChannel,
;???	eMidiSmfEvtClassSysEx,
;???	eMidiSmfEvtClassMeta
;???	} MidiSmfEvtClassEnum;

;???typedef enum MidiSmfEvtEnum {
;???	eMidiSmfEvtUnknown		= 0,
;???	eMidiSmfEvtNoteOff		= 0x080,
;???	eMidiSmfEvtNoteOn			= 0x090,
;???	eMidiSmfEvtPolyPress		= 0x0A0,
;???	eMidiSmfEvtCtlChange		= 0x0B0,
;???	eMidiSmfEvtProgChange	= 0x0C0,
;???	eMidiSmfEvtChanPress		= 0x0D0,
;???	eMidiSmfEvtPitchBend		= 0x0E0,
;???	eMidiSmfEvtSysEx1			= 0x0F0,
;???	eMidiSmfEvtSysEx2			= 0x0F7,
;???	eMidiSmfMetaEvtEOT		= 0xFF2F,
;???	eMidiSmfMetaEvtTempo		= 0xFF51,
;???	eMidiSmfMetaEvtOther		= 0xFF80
;???	} MidiSmfEvtEnum;

struct MidiEventType
	id.w		;MidiSmfEvtEnum
	evtClass.w	;MidiSmfEvtClassEnum
	dwDeltaTicks.l
	bChan.b
	evtData.l
endstruct

struct setTempo
	dwTempo.l
endstruct

struct note
	bKey.b
	bVel.b
endstruct


; System\ModemMgr.h

mdmMaxStringSize	equ	40

mdmCmdBufSize	equ	81
mdmRespBufSize	equ	81
mdmCmdSize	equ	8

mdmDefCmdTimeOut	equ	500000

mdmDefDTWaitSec	equ	4
mdmDefDCDWaitSec	equ	70
mdmDefSpeakerVolume	equ	1

;???enum {
;???	mdmVolumeOff = 0,
;???	mdmVolumeLow = 1,
;???	mdmVolumeMed = 2,
;???	mdmVolumeHigh = 3
;???	};

;???typedef enum {
;???	mdmStageInvalid = 0,
;???	mdmStageReserved = 1,
;???	mdmStageFindingModem,
;???	mdmStageInitializing,
;???	mdmStageDialing,
;???	mdmStageWaitingForCarrier,
;???	mdmStageHangingUp
;???	} MdmStageEnum;

struct MdmInfoType
	serRefNum.w
	initialBaud.l
	cmdTimeOut.l
	dtWaitSec.w
	dcdWaitSec.w
	volume.w
	pulse.b
	hwHShake.b
	autoBaud.b
	pad.b
	canProcP.l
	userRef.l
	cmdBuf.81
	respBuf.81
	connectBaud.l
	curStage.b
	pad2.b
endstruct MdmInfoTypeMdmInfoType

mdmErrNoTone	equ	mdmErrorClass | 1
mdmErrNoDCD	equ	mdmErrorClass | 2
mdmErrBusy	equ	mdmErrorClass | 3
mdmErrUserCan	equ	mdmErrorClass | 4
mdmErrCmdError	equ	mdmErrorClass | 5
mdmErrNoModem	equ	mdmErrorClass | 6
mdmErrMemory	equ	mdmErrorClass | 7
mdmErrPrefs	equ	mdmErrorClass | 8
mdmErrDial	equ	mdmErrorClass | 9


; System\ModemPrv.h

mdmDefaultResponseWait	equ	300000

;???typedef enum  {
;???	mdmCmdCSI,
;???	mdmCmdEOC,
;???	mdmCmdQuiet,
;???	mdmCmdDialTone,
;???	mdmCmdDialPulse,
;???	mdmCmdEchoOff,
;???	mdmCmdVerbose,
;???	mdmCmdDTWait,
;???	mdmCmdDCDWait,
;???	mdmCmdBasicXCmd,
;???	mdmCmdAdvXCmd,
;???	mdmCmdSpkrOnTillConnect,
;???	mdmCmdSpkrOff,
;???	mdmCmdVolume,
;???	mdmCmdHUP,
;???	mdmCmdFirmDTRDCD,
;???	mdmCmdEscape,
;???	mdmCmdReset,
;???	mdmCmdFactory,
;???	mdmCmdRetToCmdMode
;???	} MdmCmdEnum;

;???typedef enum MdmRespIDType {
;???	mdmRespUnknown = 0,
;???	mdmRespOK,
;???	mdmRespConnect,
;???	mdmRespNoCarrier,
;???	mdmRespError,
;???	mdmRespNoDialTone,
;???	mdmRespBusy,
;???	mdmRespRing,
;???
;???	mdmRespReserved = -1
;???	} MdmRespIDType;

;???enum {
;???	mdmHandshakeStd		= 0,
;???	mdmHandshakeOff		= 1,
;???	mdmHandshakeOn			= 2
;???	};

mdmPrefVersionNum	equ	2

;struct MdmPrefType
;	version.w
;	baud.l
;	volume.b
;	pulse.b
;	hShk.b
;	autoBaud.b
;	resetString[(mdmCmdSize*2)+1].b
;	initString[mdmCmdBufSize].b
;endstruct MdmPrefTypeMdmPrefType

mdmDefaultDialMode	equ	false

mdmDefaultBaud		equ	19200
;mdmDefaultVolume	equ	mdmVolumeow
mdmDefaultPulse		equ	false
;mdmDefaultHShk		equ	mdmHandshakeStd
mdmDefaultAutoBaud	equ	false
;mdmDefaultResetString	equ	""
;mdmDefaultInitString	equ	"&F&B1X4"


; System\NewFloatMgr.h

flpVersion	equ	$02008000

flpToNearest	equ	0
flpTowardZero	equ	1
flpUpward	equ	3
flpDownward	equ	2
flpModeMask	equ	$00000030
flpModeShift	equ	4

flpInvalid	equ	$00008000
flpOverflow	equ	$00004000
flpUnderflow	equ	$00002000
flpDivByZero	equ	$00001000
flpInexact	equ	$00000800

flpEqual	equ	0
flpLess		equ	1
flpGreater	equ	2
flpUnordered	equ	3

struct _sfpe_64_bits
	high.l
	low.l
endstruct

struct FlpDoubleBits
	sign.l
	exp.l
	manH.l
	manL.l
endstruct

;???typedef union {
;???        double				d;
;???        FlpDouble			fd;
;???        DWord				ul[2];
;???        FlpDoubleBits	fdb;
;???} FlpCompDouble;

;???typedef union {
;???        float				f;
;???        FlpFloat			ff;
;???        DWord				ul;
;???} FlpCompFloat;

flpErrOutOfRange	equ	flpErrorClass | 1

m68kMoveQd2Instr	equ	$7400

;???typedef enum {
;???	sysFloatBase10Info = 0,
;???	sysFloatFToA,
;???	sysFloatAToF,
;???	sysFloatCorrectedAdd,
;???	sysFloatCorrectedSub,
;???	sysFloatVersion,
;???	flpMaxFloatSelector = sysFloatVersion
;???} sysFloatSelector;

;???typedef enum {
;???	sysFloatEm_fp_round = 0,
;???	sysFloatEm_fp_get_fpscr,
;???	sysFloatEm_fp_set_fpscr,
;???	sysFloatEm_f_utof,
;???	sysFloatEm_f_itof,
;???	sysFloatEm_f_ulltof,
;???	sysFloatEm_f_lltof,
;???	sysFloatEm_d_utod,
;???	sysFloatEm_d_itod,
;???	sysFloatEm_d_ulltod,
;???	sysFloatEm_d_lltod,
;???	sysFloatEm_f_ftod,
;???	sysFloatEm_d_dtof,
;???	sysFloatEm_f_ftoq,
;???	sysFloatEm_f_qtof,
;???	sysFloatEm_d_dtoq,
;???	sysFloatEm_d_qtod,
;???	sysFloatEm_f_ftou,
;???	sysFloatEm_f_ftoi,
;???	sysFloatEm_f_ftoull,
;???	sysFloatEm_f_ftoll,
;???	sysFloatEm_d_dtou,
;???	sysFloatEm_d_dtoi,
;???	sysFloatEm_d_dtoull,
;???	sysFloatEm_d_dtoll,
;???	sysFloatEm_f_cmp,
;???	sysFloatEm_f_cmpe,
;???	sysFloatEm_f_feq,
;???	sysFloatEm_f_fne,
;???	sysFloatEm_f_flt,
;???	sysFloatEm_f_fle,
;???	sysFloatEm_f_fgt,
;???	sysFloatEm_f_fge,
;???	sysFloatEm_f_fun,
;???	sysFloatEm_f_for,
;???	sysFloatEm_d_cmp,
;???	sysFloatEm_d_cmpe,
;???	sysFloatEm_d_feq,
;???	sysFloatEm_d_fne,
;???	sysFloatEm_d_flt,
;???	sysFloatEm_d_fle,
;???	sysFloatEm_d_fgt,
;???	sysFloatEm_d_fge,
;???	sysFloatEm_d_fun,
;???	sysFloatEm_d_for,
;???	sysFloatEm_f_neg,
;???	sysFloatEm_f_add,
;???	sysFloatEm_f_mul,
;???	sysFloatEm_f_sub,
;???	sysFloatEm_f_div,
;???	sysFloatEm_d_neg,
;???	sysFloatEm_d_add,
;???	sysFloatEm_d_mul,
;???	sysFloatEm_d_sub,
;???	sysFloatEm_d_div
;???} sysFloatEmSelector;


; System\Password.h

pwdLength	equ	32
pwdEncryptionKeyLength	equ	64


; System\PenMgr.h

penErrBadParam	equ	penErrorClass | 1


; System\PenPrv.h

penCalibrateTop	equ	10
penCalibrateLeft	equ	10
penCalibrateBottom	equ	hwrDisplayHeight-10
penCalibrateRight	equ	hwrDisplayWidth-10

penInitDelay	equ	$180

penBBDelay	equ	105
penInitMaxDDZ	equ	12
penInitMaxSlop	equ	2
penInitMaxRetries	equ	3
penInitMaxEndBlip	equ	5

penNumSamples	equ	5

penHotSample	equ	2

penMinUpSamples	equ	3
penMinDownSamples	equ	1

penDownButInvalid	equ	$7FFF

struct PenGlobalsType
	calibrated.b
	filler.b
	xOffset.w
	yOffset.w
	xScale.w
	yScale.w
	sample.20
	delay.w
	maxDDZ.w
	maxRetries.w
	maxSlop.w
	maxEndBlip.w
	penDownCount.w
	penDownCountInit.w
endstruct


; System\PilotStdio.h

SEEK_SET	equ	fileOriginBeginning
SEEK_CUR	equ	fileOriginCurrent
SEEK_END	equ	fileOriginEnd


; System\SysConfigPrv.h

mem32K	equ	$008000
mem64K	equ	$010000
mem96K	equ	$018000
mem128K	equ	$020000
mem256K	equ	$040000
mem512K	equ	$080000
mem1MB	equ	$100000
mem2MB	equ	$200000


; System\SysEvtMgr.h

evtErrParamErr		equ	evtErrorClass | 1
evtErrQueueFull		equ	evtErrorClass | 2
evtErrQueueEmpty	equ	evtErrorClass | 3


; UI\Rect.h

struct AbsRectType
	left.w
	top.w
	right.w
	bottom.w
endstruct

struct PointType
	x.w
	y.w
endstruct

struct RectangleType
	topLeft.PointType
	extent.PointType
endstruct


; System\SysEvtPrv.h

struct PenQueueType
	start.w
	end.w
	size.w
	strokeCount.w
	returnedPenDown.b
	pad.b
	addLast.PointType
	addStrokeStart.w
	strokesRemoved.w
	strokesAdded.w
	rmvStrokeStage.w
	rmvLast.PointType
	rmvStartPt.PointType
	data.b
endstruct

struct KeyQueueType
	start.w
	end.w
	size.w
	data.b
endstruct

struct PenBtnInfoType
	boundsR.RectangleType
	asciiCode.w
	keyCode.w
	modifiers.w
endstruct

evtKeyStringEscape	equ	$01

evtDefaultPenQSize	equ	$100
evtDefaultKeyQSize	equ	$40

grmGremlinsOn	equ	$01
grmEventTraceOn	equ	$02
grmGremlinsIdle	equ	$04

struct SysEvtMgrGlobalsType
	sendNullEvent.b
	enableGraffiti.b
	enableSoftKeys.b
	removeTopStroke.b
	penQP.l
	penQStrokesRemoved.w
	keyQP.l
	writingR.RectangleType
	appAreaBottom.w
	penX.w
	penY.w
	penDown.b
	displayingBatteryAlert.b
	lastPenX.w
	lastPenY.w
	lastPenDown.b
	needRemoteScrUpdate.b
	gremlinsFlags.b
	idle.b
endstruct


; UI\WindowNew.h

up	equ	0
down	equ	1
left	equ	3
right	equ	4

; windowFormats
screenFormat	equ	0
genericFormat	equ	1

; ScrOperation
scrCopy	equ	0
scrAND	equ	1
scrANDNOT	equ	2
scrXOR	equ	3
scrOR	equ	4
scrCopyNOT	equ	5

; patterns
blackPattern	equ	0
whitePattern	equ	1
grayPattern	equ	2
customPattern	equ	3

grayHLinePattern	equ	$AA

; underlineModes
noUnderline	equ	0
grayUnderline	equ	1
solidUnderline	equ	2

BitmapFlagsType_compressed	equ	$0001
BitmapFlagsType_hasColorTable	equ	$0002

struct BitmapType
	width.w
	height.w
	rowBytes.w
	flags.w
	pixelSize.b
	version.b
	nextDepthOffset.l
	reserved.4
	Bits.b
endstruct

struct RGBColorType
	unused.b
	red.b
	green.b
	blue.b
endstruct

struct ColorTableType
	numEntries.w
	entry.RGBColorType
endstruct

struct GraphicStateType
	grafMode.b
	patternMode.b
	pattern.w
	customPtn.8
	fontId.b
	padding1.b
	font.l
	underlineMode.w
	foreColor.RGBColorType
	backColor.RGBColorType
endstruct

;typedef union {
;	struct {
;		Word cornerDiam   : 8;            // corner diameter, max 38
;		Word reserved_3   : 3;
;		Word threeD			: 1;			;	// Draw 3D button    ;
;		Word s;hadowWidth  : 2;            // Width of shadow
;		Word w;idth        : 2;            // Width frame
;	} bits;;
;	Word wo;rd;								;// IMPORTANT: INITIALIZE word to zero before setting bits!
;;noFrame	equ	0
;impleFrame	equ	1
;ectangleFrame	equ	1
;imple3DFrame	equ	$0012
;oundFrame	equ	$0401
;oldRoundFrame	equ	$0702
;opupFrame	equ	$0205
;ialogFrame	equ	$0302
;enuFrame	equ	popupFrame
;;WindowFlagsType_format_shift     equ 0
;indowFlagsType_format_count     equ 1
;indowFlagsType_format_mask      equ $00000001
;indowFlagsType_offscreen_shift  equ 1
;indowFlagsType_offscreen_count  equ 1
;indowFlagsType_offscreen_mask   equ $00000002
;indowFlagsType_modal_shift      equ 2
;indowFlagsType_modal_count      equ 1
;indowFlagsType_modal_mask       equ $00000004
;indowFlagsType_focusable_shift  equ 3
;indowFlagsType_focusable_count  equ 1
;indowFlagsType_focusable_mask   equ $00000008
;indowFlagsType_enabled_shift    equ 4
;indowFlagsType_enabled_count    equ 1
;indowFlagsType_enabled_mask     equ $00000010
;indowFlagsType_visible_shift    equ 5
;indowFlagsType_visible_count    equ 1
;indowFlagsType_visible_mask     equ $00000020
;indowFlagsType_dialog_shift     equ 6
;indowFlagsType_dialog_count     equ 1
;indowFlagsType_dialog_mask      equ $00000040
;indowFlagsType_compressed_shift equ 7
;indowFlagsType_compressed_count equ 1
;indowFlagsType_compressed_mask  equ $00000080
;indowFlagsType_reserved_shift   equ 8
;indowFlagsType_reserved_count   equ 8
;indowFlagsType_reserved_mask    equ $0000ff00
;;struct GDeviceType
;baseAddr.l
;width.w
;height.w
;rowBytes.w
;pixelSize.b
;version.b
;flages.w
;	forDriver:1.w
;	dynamic:1.w
;	compressed:1.w
;	flags:13.w
;	cTableP.l
;endstruct

struct WindowType
	displayWidthV20.w
	displayHeightV20.w
	displayAddrV20.l
	windowFlags.w
	windowBounds.RectangleType
	clippingBounds.AbsRectType
	gDeviceP.l
	frameType.w
	gstate.l
	nextWindow.l
endstruct


; UI\Control.h

ControlAttrType_usable_shift     equ 0
ControlAttrType_usable_count     equ 1
ControlAttrType_usable_mask      equ $00000001
ControlAttrType_enabled_shift    equ 1
ControlAttrType_enabled_count    equ 1
ControlAttrType_enabled_mask     equ $00000002
ControlAttrType_visible_shift    equ 2
ControlAttrType_visible_count    equ 1
ControlAttrType_visible_mask     equ $00000004
ControlAttrType_on_shift         equ 3
ControlAttrType_on_count         equ 1
ControlAttrType_on_mask          equ $00000008
ControlAttrType_leftAnchor_shift equ 4
ControlAttrType_leftAnchor_count equ 1
ControlAttrType_leftAnchor_mask  equ $00000010
ControlAttrType_frame_shift      equ 5
ControlAttrType_frame_count      equ 3
ControlAttrType_frame_mask       equ $000000e0

;controlStyles
buttonCtl	equ	0
pushButtonCtl	equ	1
checkboxCtl	equ	2
popupTriggerCtl	equ	3
selectorTriggerCtl	equ	4
repeatingButtonCtl	equ	5

; buttonFrames
noButtonFrame	equ	0
standardButtonFrame	equ	1
boldButtonFrame	equ	2
rectangleButtonFrame	equ	3

struct ControlType
	id.w
	bounds.RectangleType
	text.l
	attr.w		;ControlAttrType
	style.w		;ControlStyleType
	font.b		;FontID
	group.b
endstruct


; UI\Category.h

struct AppInfoType
	renamedCategories.w
	categoryLabels.256
	categoryUniqIDs.16
	lastUniqID.b
endstruct


; UI\CharAttr.h

_XA	equ	$200
_XS	equ	$100
_BB	equ	$80
_CN	equ	$40
_DI	equ	$20
_LO	equ	$10
_PU	equ	$08
_SP	equ	$04
_UP	equ	$02
_XD	equ	$01


; UI\Chars.h

downArrowChr	equ	$1F
upArrowChr	equ	$1E
leftArrowChr	equ	$1C
rightArrowChr	equ	$1D

pageUpChr	equ	$0B
pageDownChr	equ	$0C

lowBatteryChr	equ	$0101
enterDebuggerChr	equ	$0102
nextFieldChr	equ	$0103
startConsoleChr	equ	$0104
menuChr	equ	$0105
commandChr	equ	$0106
confirmChr	equ	$0107
launchChr	equ	$0108
keyboardChr	equ	$0109
findChr	equ	$010A
calcChr	equ	$010B
prevFieldChr	equ	$010C
alarmChr	equ	$010D
ronamaticChr	equ	$010E
graffitiReferenceChr	equ	$010F
keyboardAlphaChr	equ	$0110
keyboardNumericChr	equ	$0111
lockChr	equ	$0112
backlightChr	equ	$0113
autoOffChr	equ	$0114
exgTestChr	equ	$0115
sendDataChr	equ	$0116
irReceiveChr	equ	$0117

hardKeyMin	equ	$0200
hardKeyMax	equ	$02FF
hard1Chr	equ	$0204
hard2Chr	equ	$0205
hard3Chr	equ	$0206
hard4Chr	equ	$0207
hardPowerChr	equ	$0208
hardCradleChr	equ	$0209
hardCradle2Chr	equ	$020A

nullChr	equ	$00
backspaceChr	equ	$08
tabChr	equ	$09
linefeedChr	equ	$0A
crChr	equ	$0D
colonChr	equ	':'
periodChr	equ	'.'
commaChr	equ	','
quoteChr	equ	'"'

returnChr	equ	$0D
escapeChr	equ	$1B
spaceChr	equ	$20
lastAsciiChr	equ	$FF

numericSpaceChr	equ	$80

cutChr	equ	$12D
copyChr	equ	$12E
pasteChr	equ	$12F

lowSingleCommaQuoteChr	equ	$82
scriptFChr	equ	$83
lowDblCommaQuoteChr	equ	$84
horizEllipsisChr	equ	$85
daggerChr	equ	$86
dblDaggerChr	equ	$87
circumflexChr	equ	$88
perMilleChr	equ	$89
upSHacekChr	equ	$8A
leftSingleGuillemetChr	equ	$8B
upOEChr	equ	$8C

clubChr	equ	$8E
heartChr	equ	$8F
spadeChr	equ	$90
singleOpenCommaQuoteChr	equ	$91
singleCloseCommaQuoteChr	equ	$92
dblOpenCommaQuoteChr	equ	$93
dblCloseCommaQuoteChr	equ	$94
bulletChr	equ	$95
enDashChr	equ	$96
emDashChr	equ	$97
spacingTildeChr	equ	$98
trademarkChr	equ	$99
lowSHacekChr	equ	$9A
rightSingleGuillemetChr	equ	$9B
lowOEChr	equ	$9C
commandStrokeChr	equ	$9D
shortcutStrokeChr	equ	$9E
upYDiaeresisChr	equ	$9F
nonBreakSpaceChr	equ	$A0
invertedExclamationChr	equ	$A1
centChr	equ	$A2
poundChr	equ	$A3
currencyChr	equ	$A4
yenChr	equ	$A5
brokenVertBarChr	equ	$A6
sectionChr	equ	$A7
spacingDiaeresisChr	equ	$A8
copyrightChr	equ	$A9
feminineOrdinalChr	equ	$AA
leftGuillemetChr	equ	$AB
notChr	equ	$AC
softHyphenChr	equ	$AD
registeredChr	equ	$AE
spacingMacronChr	equ	$AF
degreeChr	equ	$B0
plusMinusChr	equ	$B1
superscript2Chr	equ	$B2
superscript3Chr	equ	$B3
spacingAcuteChr	equ	$B4
microChr	equ	$B5
paragraphChr	equ	$B6
middleDotChr	equ	$B7
spacingCedillaChr	equ	$B8
superscript1Chr	equ	$B9
masculineOrdinalChr	equ	$BA
rightGuillemetChr	equ	$BB
fractOneQuarterChr	equ	$BC
fractOneHalfChr	equ	$BD
fractThreeQuartersChr	equ	$BE
invertedQuestionChr	equ	$BF
upAGraveChr	equ	$C0
upAAcuteChr	equ	$C1
upACircumflexChr	equ	$C2
upATildeChr	equ	$C3
upADiaeresisChr	equ	$C4
upARingChr	equ	$C5
upAEChr	equ	$C6
upCCedillaChr	equ	$C7
upEGraveChr	equ	$C8
upEAcuteChr	equ	$C9
upECircumflexChr	equ	$CA
upEDiaeresisChr	equ	$CB
upIGraveChr	equ	$CC
upIAcuteChr	equ	$CD
upICircumflexChr	equ	$CE
upIDiaeresisChr	equ	$CF
upEthChr	equ	$D0
upNTildeChr	equ	$D1
upOGraveChr	equ	$D2
upOAcuteChr	equ	$D3
upOCircumflexChr	equ	$D4
upOTildeChr	equ	$D5
upODiaeresisChr	equ	$D6
multiplyChr	equ	$D7
upOSlashChr	equ	$D8
upUGraveChr	equ	$D9
upUAcuteChr	equ	$DA
upUCircumflexChr	equ	$DB
upUDiaeresisChr	equ	$DC
upYAcuteChr	equ	$DD
upThorn	equ	$DE
lowSharpSChr	equ	$DF
lowAGraveChr	equ	$E0
lowAAcuteChr	equ	$E1
lowACircumflexChr	equ	$E2
lowATildeChr	equ	$E3
lowADiaeresisChr	equ	$E4
lowARingChr	equ	$E5
lowAEChr	equ	$E6
lowCCedillaChr	equ	$E7
lowEGraveChr	equ	$E8
lowEAcuteChr	equ	$E9
lowECircumflexChr	equ	$EA
lowEDiaeresisChr	equ	$EB
lowIGraveChr	equ	$EC
lowIAcuteChr	equ	$ED
lowICircumflexChr	equ	$EE
lowIDiaeresisChr	equ	$EF
lowEthChr	equ	$F0
lowNTildeChr	equ	$F1
lowOGraveChr	equ	$F2
lowOAcuteChr	equ	$F3
lowOCircumflexChr	equ	$F4
lowOTildeChr	equ	$F5
lowODiaeresisChr	equ	$F6
divideChr	equ	$F7
lowOSlashChr	equ	$F8
lowUGraveChr	equ	$F9
lowUAcuteChr	equ	$FA
lowUCircumflexChr	equ	$FB
lowUDiaeresisChr	equ	$FC
lowYAcuteChr	equ	$FD
lowThorn	equ	$FE
lowYDiaeresisChr	equ	$FF

; symbolChars
symbolLeftArrow	equ	3
symbolRightArrow	equ	4
symbolUpArrow	equ	5
symbolDownArrow	equ	6
symbolSmallDownArrow	equ	7
symbolSmallUpArrow	equ	8
symbolMemo	equ	9
symbolHelp	equ	10
symbolNote	equ	11
symbolNoteSelected	equ	12
symbolCapsLock	equ	13
symbolNumLock	equ	14
symbolShiftUpper	equ	15
symbolShiftPunc	equ	16
symbolShiftExt	equ	17
symbolShiftNone	equ	18
symbolNoTime	equ	19
symbolAlarm	equ	20
symbolRepeat	equ	21
symbolCheckMark	equ	22

;symbol7Chars
symbol7ScrollUp	equ	1
symbol7ScrollDown	equ	2
symbol7ScrollUpDisabled	equ	3
symbol7ScrollDownDisabled	equ	4

; symbol11Chars
symbolCheckboxOff	equ	0
symbolCheckboxOn	equ	1
symbol11LeftArrow	equ	2
symbol11RightArrow	equ	3


; System\Keyboard.h

kbdReturnKey	equ	linefeedChr
kbdTabKey	equ	tabChr
kbdBackspaceKey	equ	backspaceChr
kbdShiftKey	equ	2
kbdCapsKey	equ	1
kbdNoKey	equ	$ff

; KeyboardType
kbdAlpha	equ	0
kbdNumbersAndPunc	equ	1
kbdAccent	equ	2
kbdDefault	equ	$ff


; UI\ClipBoard.h

numClipboardForamts	equ	3
cbdMaxTextLength	equ	1000

; clipboardFormats
clipboardText	equ	0
clipboardInk	equ	1
clipboardBitmap	equ	2

struct ClipboardItem
	item.l
	length.w
endstruct


; UI\Day.h

; SelectDayType
selectDayByDay	equ	0
selectDayByWeek	equ	1
selectDayByMonth	equ	2

struct DaySelectorType
	bounds.RectangleType
	visible.w
	visibleMonth.w
	visibleYear.w
	selected.DateTimeType
	selectDayBy.b	;SelectDayType
	pad.b
endstruct


; UI\Event.H

; events
nilEvent	equ	0
penDownEvent	equ	1
penUpEvent	equ	2
penMoveEvent	equ	3
keyDownEvent	equ	4
winEnterEvent	equ	5
winExitEvent	equ	6
ctlEnterEvent	equ	7
ctlExitEvent	equ	8
ctlSelectEvent	equ	9
ctlRepeatEvent	equ	10
lstEnterEvent	equ	11
lstSelectEvent	equ	12
lstExitEvent	equ	13
popSelectEvent	equ	14
fldEnterEvent	equ	15
fldHeightChangedEvent	equ	16
fldChangedEvent	equ	17
tblEnterEvent	equ	18
tblSelectEvent	equ	19
daySelectEvent	equ	20
menuEvent	equ	21
appStopEvent	equ	22
frmLoadEvent	equ	23
frmOpenEvent	equ	24
frmGotoEvent	equ	25
frmUpdateEvent	equ	26
frmSaveEvent	equ	27
frmCloseEvent	equ	28
;tblExitEvent	equ	29	; PalmOS 1.0
frmTitleEnterEvent	equ	29
frmTitleSelectEvent	equ	30
tblExitEvent	equ	31
sclEnterEvent	equ	32
sclExitEvent	equ	33
sclRepeatEvent	equ	34
firstUserEvent	equ	32767

shiftKeyMask	equ	$0001
capsLockMask	equ	$0002
numLockMask	equ	$0004
commandKeyMask	equ	$0008
optionKeyMask	equ	$0010
controlKeyMask	equ	$0020
autoRepeatKeyMask	equ	$0040
doubleTapKeyMask	equ	$0080
poweredOnKeyMask	equ	$0100
appEvtHookKeyMask	equ	$0200
libEvtHookKeyMask	equ	$0400

evtWaitForever	equ	-1

struct EventType
	eType.w
	penDown.w
	screenX.w
	screenY.w
	data.16
endstruct

; union data

struct generic
	data1.w
	data2.w
	data3.w
	data4.w
	data5.w
	data6.w
	data7.w
	data8.w
endstruct

struct penUp
	start.PointType
	end.PointType
endstruct

struct keyDown
	chr.w
	keyCode.w
	modifiers.w
endstruct

struct winEnter
	enterWindow.l
	exitWindow.l
endstruct

struct winExit
	enterWindow.l
	exitWindow.l
endstruct

struct ctlEnter
	controlID.w
	pControl.l
endstruct

struct ctlSelect
	controlID.w
	pControl.l
	on.b
	bPad.b
endstruct

struct ctlRepeat
	controlID.w
	pControl.l
	time.l
endstruct

struct fldEnter
	fieldID.w
	pField.l
endstruct

struct fldHeightChanged
	fieldID.w
	pField.l
	newHeight.w
	currentPos.w
endstruct

struct fldChanged
	fieldID.w
	pField.l
endstruct

struct fldExit
	fieldID.w
	pField.l
endstruct

struct lstEnter
	listID.w
	pList.l
	selection.w
endstruct

struct lstExit
	listID.w
	pList.l
endstruct

struct lstSelect
	listID.w
	pList.l
	selection.w
endstruct

struct tblEnter
	tableID.w
	pTable.l
	row.w
	column.w
endstruct

struct tblExit
	tableID.w
	pTable.l
	row.w
	column.w
endstruct

struct tblSelect
	tableID.w
	pTable.l
	row.w
	column.w
endstruct

struct frmLoad
	formID.w
endstruct

struct frmOpen
	formID.w
endstruct

struct frmGoto
	formID.w
	recordNum.w
	matchPos.w
	matchLen.w
	matchFieldNum.w
	matchCustom.l
endstruct

struct frmClose
	formID.w
endstruct

struct frmUpdate
	formID.w
	updateCode.w
endstruct

struct frmTitleEnter
	formID.w
endstruct

struct frmTitleSelect
	formID.w
endstruct

struct daySelect
	pSelector.l
	selection.w
	useThisDate.b
	bPad.b
endstruct

struct menu
	itemID.w
endstruct

struct popSelect
	controlID.w
	controlP.l
	listID.w
	listP.l
	selection.w
	priorSelection.w
endstruct

struct sclEnter
	scrollBarID.w
	pScrollBar.l
endstruct

struct sclExit
	scrollBarID.w
	pScrollBar.l
	value.w
	newValue.w
endstruct

struct sclRepeat
	scrollBarID.w
	pScrollBar.l
	value.w
	newValue.w
	time.l
endstruct

struct EventStoreType
	event.w
	id.l
endstruct EventStoreType


; System\INetMgr.h

inetCreator	equ	'inet'
inetLibFtrCreator	equ	inetCreator
inetFtrNumVersion	equ	0
inetLibType	equ	'libr'

inetOpenFlagOKWireless	equ	$00000001
inetOpenFlagOKWireline	equ	$00000002
inetOpenFlagPreferWireless	equ	$00000004

inetErrTooManyClients		equ	inetErrorClass | 1
inetErrHandleInvalid		equ	inetErrorClass | 2
inetErrParamsInvalid		equ	inetErrorClass | 3
inetErrURLVersionInvalid	equ	inetErrorClass | 4
inetErrURLBufTooSmall		equ	inetErrorClass | 5
inetErrURLInvalid		equ	inetErrorClass | 6
inetErrTooManySockets		equ	inetErrorClass | 7
inetErrNoRequestCreated	equ	inetErrorClass | 8
inetErrNotConnected		equ	inetErrorClass | 9
inetErrInvalidRequest		equ	inetErrorClass | 10
inetErrNeedTime		equ	inetErrorClass | 11
inetErrHostnameInvalid		equ	inetErrorClass | 12
inetErrInvalidPort		equ	inetErrorClass | 13
inetErrInvalidHostAddr		equ	inetErrorClass | 14
inetErrNilBuffer		equ	inetErrorClass | 15
inetErrConnectTimeout		equ	inetErrorClass | 16
inetErrResolveTimeout		equ	inetErrorClass | 17
inetErrSendReqTimeout		equ	inetErrorClass | 18
inetErrReadTimeout		equ	inetErrorClass | 19
inetErrBufTooSmall		equ	inetErrorClass | 20
inetErrSchemeNotSupported	equ	inetErrorClass | 21
inetErrInvalidResponse		equ	inetErrorClass | 22

; INetSchemeEnum
inetSchemeUnknown	equ	-1
inetSchemeDefault	equ	0
inetSchemeHTTP	equ	1
inetSchemeHTTPS	equ	2
inetSchemeFTP	equ	3
inetSchemeGopher	equ	4
inetSchemeFile	equ	5
inetSchemeNews	equ	6
inetSchemeMailTo	equ	7
inetSchemeMail	equ	8
inetSchemeFirst	equ	inetSchemeHTTP
inetSchemeLast	equ	inetSchemeMail

struct INetURLType
	version.w
	schemeP.l
	schemeLen.w
	schemeEnum.w
	hostnameP.l
	hostnameLen.w
	port.w
	usernameP.l
	usernameLen.w
	passwordP.l
	passwordLen.w
	pathP.l
	pathLen.w
	extraInfoP.l
	extraInfoLen.w
endstruct

; INetProxyEnum
inetProxyNone	equ	0
inetProxyJerry	equ	1

; INetSettingEnum;
inetSettingProxyType	equ	0
inetSettingJerryProxyName	equ	1
inetSettingJerryProxyPort	equ	2
inetSettingJerryProxyAddrGrMAN	equ	3
inetSettingJerryProxyAddrMAN	equ	4
inetSettingWirelessNetwork	equ	5
inetSettingSockContext	equ	6
inetSettingLast	equ	7

; INetStatusEnum;
inetStatusNew			equ	0
inetStatusResolvingName		equ	1
inetStatusNameResolved		equ	2
inetStatusConnecting		equ	3
inetStatusConnected		equ	4
inetStatusSendingRequest	equ	5
inetStatusWaitingForResponse	equ	6
inetStatusReceivingResponse	equ	7
inetStatusResponseReceived	equ	8
inetStatusClosingConnection	equ	9

; INetHTTPAttrEnum;
inetHTTPAttrCommErr		equ	0
inetHTTPAttrEntityURL		equ	1
inetHTTPAttrReqAuthorization	equ	2
inetHTTPAttrReqFrom		equ	3
inetHTTPAttrReqIfModifiedSince	equ	4
inetHTTPAttrReqReferer		equ	5
inetHTTPAttrRspAll		equ	6
inetHTTPAttrRspVersion		equ	7
inetHTTPAttrStatusCode		equ	8
inetHTTPAttrReason		equ	9
inetHTTPAttrDate		equ	10
inetHTTPAttrNoCache		equ	11
inetHTTPAttrPragma		equ	12
inetHTTPAttrServer		equ	13
inetHTTPAttrWWWAuthentication	equ	14
inetHTTPAttrContentAllow	equ	15
inetHTTPAttrContentEncoding	equ	16
inetHTTPAttrContentLength	equ	17
inetHTTPAttrContentPtr		equ	18
inetHTTPAttrContentType		equ	19
inetHTTPAttrContentExpires	equ	20
inetHTTPAttrContentLastModified	equ	21
inetHTTPAttrContentLocation	equ	22

inetSockReadyEvent		equ	firstUserEvent
inetSockStatusChangeEvent	equ	firstUserEvent+1
inetLastEvent			equ	firstUserEvent+1

struct INetEventType
	eType.b
	penDown.b
	screenX.w
	screenY.w
	union.16
endstruct

struct generic
	data1.w
	data2.w
	data3.w
	data4.w
	data5.w
	data6.w
	data7.w
	data8.w
endstruct

struct inetSockReady
	sockH.l
	context.l
	inputReady.b
	outputReady.b
endstruct

struct inetSockStatusChange
	sockH.l
	context.l
	status.w
	sockErr.w
endstruct

; INetLibTrapNumberEnum;
inetLibTrapSettingGet	equ	sysLibTrapCustom
inetLibTrapSettingSet	equ	sysLibTrapCustom+1
inetLibTrapGetEvent	equ	sysLibTrapCustom+2
inetLibTrapURLOpen	equ	sysLibTrapCustom+3
inetLibTrapSockRead	equ	sysLibTrapCustom+4
inetLibTrapSockWrite	equ	sysLibTrapCustom+5
inetLibTrapSockOpen	equ	sysLibTrapCustom+6
inetLibTrapSockClose	equ	sysLibTrapCustom+7
inetLibTrapSockStatus	equ	sysLibTrapCustom+8
inetLibTrapSockSettingGet	equ	sysLibTrapCustom+9
inetLibTrapSockSettingSet	equ	sysLibTrapCustom+10
inetLibTrapSockConnect	equ	sysLibTrapCustom+11
inetLibTrapURLCrack	equ	sysLibTrapCustom+12
inetLibTrapSockHTTPReqCreate	equ	sysLibTrapCustom+13
inetLibTrapSockHTTPAttrSet	equ	sysLibTrapCustom+14
inetLibTrapSockHTTPReqSend	equ	sysLibTrapCustom+15
inetLibTrapSockHTTPAttrGet	equ	sysLibTrapCustom+16
inetLibTrapSockMailReqCreate	equ	sysLibTrapCustom+17
inetLibTrapSockMailAttrSet	equ	sysLibTrapCustom+18
inetLibTrapSockMailReqAdd	equ	sysLibTrapCustom+19
inetLibTrapSockMailReqSend	equ	sysLibTrapCustom+20
inetLibTrapSockMailAttrGet	equ	sysLibTrapCustom+21
inetLibTrapSockMailQueryProgress	equ	sysLibTrapCustom+22
inetLibTrapLast	equ	sysLibTrapCustom+23


; System\INetMgrMail.h

; inetMailAttrEnum
inetMailAttrCommErr	equ	0
inetMailAttrReqEncrypted	equ	1

struct INetMailUIDType
	hi.w
	lo.l
endstruct

; INetMailCmdEnum;
inetMailCmdNew		equ	0
inetMailCmdSend		equ	1
inetMailCmdGetMore	equ	2
inetMailCmdServer	equ	3

inetMailMaxUsername	equ	32
inetMailMaxPassword	equ	32

struct INetMailNewType
	id.INetMailUIDType
	previewSize.l
	headerFieldsP.l
	availMemory.l
	truncationSize.l
	networkID.l
	username.32
	password.32
endstruct

struct INetMailSendType
	priority.w
	confirmRead.b
	confirmDelivery.b
	attachmentCount.w
	attachmentsP.l
	msgSize.l
	msgP.l
endstruct

struct INetMailGetMoreType
	id.INetMailUIDType
	bodyEndOffset.l
	headerFieldsP.l
endstruct

struct INetMailServerType
	serverCmd.l
	serverParamsLen.l
	serverParamsP.l
endstruct

inetMailContentJerry	equ	0

struct INetMailHeaderType
	proxyErr.w
	serverErr.w
	rspSize.l
	serverErr.w
	contentType.w
	newMsgs.w
	updMsgs.w
	moreMailAvail.b
	pad.b
endstruct

; INetMailRspEnum;
inetMailRspEnd			equ	0
inetMailRspNewMsg		equ	1
inetMailRspMsgAttachment	equ	2
inetMailRspUpdMsg		equ	3
inetMailRspAck			equ	4

struct INetMailRspType
	kind.w
	dataSize.l
	union.32
endstruct

struct generic
	generic.32
endstruct

struct newMsg
	id.INetMailUIDType
	addrType.w
	bodyEndOffset.l
	priority.w
	serverMsgSize.l
	serverNoteID.w
	attachmentCount.w
	timeStamp.l
endstruct

struct attachment
	type.l
endstruct

struct updMsg
	id.INetMailUIDType
	bodyEndOffset.l
	serverNoteID.w
	attachmentCount.w
endstruct

struct ack
	cmd.w
	serverErr.l
	id.INetMailUIDType
	dataType.l
endstruct


; UI\Font.h

struct FontCharInfoType
	offset.b
	width.b
endstruct

struct FontType
	fontType.w
	firstChar.w
	lastChar.w
	maxWidth.w
	kernMax.w
	nDescent.w
	fRectWidth.w
	fRectHeight.w
	owTLoc.w
	ascent.w
	descent.w
	leading.w
	rowWords.w
endstruct

; fontID
stdFont	equ	0
boldFont	equ	1
largeFont	equ	2
symbolFont	equ	3
symbol11Font	equ	4
symbol7Font	equ	5
ledFont	equ	6
largeBoldFont	equ	7
fntAppFontCustomBase	equ	$80

checkboxFont	equ	symbol11Font


; UI\Find.h

maxFinds	equ	9
maxFindStrLen	equ	16

struct FindMatchType
	appCardNo.w
	appDbID.l
	foundInCaller.w
	dbCardNo.w
	dbID.l
	recordNum.w
	matchPos.w
	matchFieldNum.w
	matchCustom.l
endstruct

struct FindParamsType
	dbAccesMode.w
	recordNum.w
	more.b
	strAsTyped.17
	strToFind.17
	pad.b
	numMatches.w
	lineNumber.w
	continuation.b
	searchedCaller.b
	callerAppDbID.l
	callerAppCardNo.w
	appDbID.l
	appCardNo.w
	newSearch.w
	searchState.DmSearchStateType
	match0.FindMatchType
	match1.FindMatchType
	match2.FindMatchType
	match3.FindMatchType
	match4.FindMatchType
	match5.FindMatchType
	match6.FindMatchType
	match7.FindMatchType
	match8.FindMatchType
endstruct

struct GoToParamsType
	searchStrLen.w
	dbCardNo.w
	dbID.l
	recordNum.w
	matchPos.w
	matchFieldNum.w
	matchCustom.l
endstruct


; UI\Field.h

maxFieldTextLen	equ	$7fff
maxFieldLines	equ	11

; justifications
leftAlign	equ	0
centerAlign	equ	1
rightAlign	equ	2

undoBufferSize	equ	100

; UndoMode
undoNone	equ	0
undoTyping	equ	1
undoBackspace	equ	2
undoDelete	equ	3
undoPaste	equ	4
undoCut		equ	5

struct FieldUndoType
	mode.w
	start.w
	end.w
	bufferLen.w
	buffer.l
endstruct

FieldAttrType_usable_shift        equ 0
FieldAttrType_usable_count        equ 1
FieldAttrType_usable_mask         equ $00000001
FieldAttrType_visible_shift       equ 1
FieldAttrType_visible_count       equ 1
FieldAttrType_visible_mask        equ $00000002
FieldAttrType_editable_shift      equ 2
FieldAttrType_editable_count      equ 1
FieldAttrType_editable_mask       equ $00000004
FieldAttrType_singleLine_shift    equ 3
FieldAttrType_singleLine_count    equ 1
FieldAttrType_singleLine_mask     equ $00000008
FieldAttrType_hasFocus_shift      equ 4
FieldAttrType_hasFocus_count      equ 1
FieldAttrType_hasFocus_mask       equ $00000010
FieldAttrType_dynamicSize_shift   equ 5
FieldAttrType_dynamicSize_count   equ 1
FieldAttrType_dynamicSize_mask    equ $00000020
FieldAttrType_insPtVisible_shift  equ 6
FieldAttrType_insPtVisible_count  equ 1
FieldAttrType_insPtVisible_mask   equ $00000040
FieldAttrType_dirty_shift         equ 7
FieldAttrType_dirty_count         equ 1
FieldAttrType_dirty_mask          equ $00000080
FieldAttrType_underlined_shift    equ 8
FieldAttrType_underlined_count    equ 2
FieldAttrType_underlined_mask     equ $00000300
FieldAttrType_justification_shift equ 10
FieldAttrType_justification_count equ 2
FieldAttrType_justification_mask  equ $00000c00
FieldAttrType_autoShift_shift     equ 12
FieldAttrType_autoShift_count     equ 1
FieldAttrType_autoShift_mask      equ $00001000
FieldAttrType_hasScrollBar_shift  equ 13
FieldAttrType_hasScrollBar_count  equ 1
FieldAttrType_hasScrollBar_mask   equ $00002000
FieldAttrType_numeric_shift       equ 14
FieldAttrType_numeric_count       equ 1
FieldAttrType_numeric_mask        equ $00004000

struct LineInfoType
	start.b
	length.b
endstruct

struct FieldType
	id.w
	rect.RectangleType
	attr.w
	text.l
	textHandle.l
	lines.l
	textLen.w
	textBlockSize.w
	maxChars.w
	selFirstPos.w
	selLastPos.w
	insPtXPos.w
	insPtYPos.w
	fontID.b
	pad.b
endstruct


; UI\Form.h

noFocus	equ	$ffff
frmRedrawUpdateCode	equ	$8000

; alertTypes
informationAlert	equ	0
confirmationAlert	equ	1
warningAlert		equ	2
errorAlert		equ 3

struct AlertTemplateType
	alertType.w
	helpRscID.w
	numButtons.w
	defaultButton.w
endstruct

; formObjects
frmFieldObj	equ	0
frmControlObj	equ	1
frmListObj	equ	2
frmTableObj	equ	3
frmBitmapObj	equ	4
frmLineObj	equ	5
frmFrameObj	equ	6
frmRectangleObj	equ	7
frmLabelObj	equ	8
frmTitleObj	equ	9
frmPopupObj	equ	10
frmGraffitiStateObj	equ	11
frmGadgetObj	equ	12
frmScrollBarObj	equ	13

FormObjAttrType_usable_shift	equ	0
FormObjAttrType_usable_count	equ	1
FormObjAttrType_usable_mask	equ	$00000001

struct FormBitmapType
	attr.w
	pos.PointType
	rscID.w
endstruct

struct FormLineType
	attr.w
	point1.PointType
	point2.PointType
endstruct

struct FormFrameType
	id.w
	attr.w
	rect.RectangleType
	frameType.w
endstruct

struct FormRectangleType
	attr.w
	rect.RectangleType
endstruct

struct FormLabelType
	id.w
	pos.PointType
	attr.b
	pad.b
	fontID.w
	text.l
endstruct

struct FormTitleType
	rect.RectangleType
	text.l
endstruct

struct FormPopupType
	controlID.w
	listID.w
endstruct

struct FrmGraffitiStateType
	pos.PointType
endstruct

struct FormGadgetType
	id.w
	attr.w
	rect.RectangleType
	data.l
endstruct

struct FormObjListType
	objectType.w
	object.l
endstruct

FormAttrType_usable_shift	equ	0
FormAttrType_usable_count	equ	1
FormAttrType_usable_mask	equ	$00000001
FormAttrType_visible_shift	equ	1
FormAttrType_visible_count	equ	1
FormAttrType_visible_mask	equ	$00000002
FormAttrType_dirty_shift	equ	2
FormAttrType_dirty_count	equ	1
FormAttrType_dirty_mask		equ	$00000004
FormAttrType_saveBehind_shift	equ	3
FormAttrType_saveBehind_count	equ	1
FormAttrType_saveBehind_mask	equ	$00000008
FormAttrType_graffitiShift_shift	equ	4
FormAttrType_graffitiShift_count	equ	1
FormAttrType_graffitiShift_mask	equ	$00000010

struct FormType
	window.WindowType
	formId.w
	attr.w
	bitsBehindForm.l
	handler.l
	focus.w
	defaultButton.w
	helpRscId.w
	menuRscId.w
	numObjects.w
	objects.l
endstruct

struct FormActiveStateType
	data.22
endstruct


; UI\GraffitiShift.h

glfCapsLock	equ	$01
glfNumLock	equ	$02


; GsiShiftState
gsiShiftNone	equ	0
gsiNumLock	equ	1
gsiCapsLock	equ	2
gsiShiftPunctuation	equ	3
gsiShiftExtended	equ	4
gsiShiftUpper	equ	5
gsiShiftLower	equ	6


; UI\List.h

noListSelection	equ	$ffff

ListAttrType_usable_shift	equ	0
ListAttrType_usable_count	equ	1
ListAttrType_usable_mask	equ	$00000001
ListAttrType_enabled_shift	equ	1
ListAttrType_enabled_count	equ	1
ListAttrType_enabled_mask	equ	$00000002
ListAttrType_visible_shift	equ	2
ListAttrType_visible_count	equ	1
ListAttrType_visible_mask	equ	$00000004
ListAttrType_poppedUp_shift	equ	3
ListAttrType_poppedUp_count	equ	1
ListAttrType_poppedUp_mask	equ	$00000008
ListAttrType_reserved_shift	equ	4
ListAttrType_reserved_count	equ	4
ListAttrType_reserved_mask	equ	$000000f0

struct ListType
	id.w
	bounds.RectangleType
	attr.b
	pad.b
	itemsText.l
	numItems.w
	currentItem.w
	topItem.w
	font.b
	pad2.b
	popupWin.l
	drawItemsCallback.l
endstruct


; UI\Menu.h

noMenuSelection	equ	-1
noMenuItemSelection	equ	-1
separatorItemSelection	equ	-2

MenuSeparatorChar	equ	'-'

struct MenuItemType
	id.w
	command.b
	itemStr.b
endstruct

struct MenuPullDownType
	menuWin.l
	bounds.RectangleType
	bitsBehind.l
	titleBounds.RectangleType
	title.l
	numItems.w
	items.l
endstruct

MenuBarAttrType_visible_shift        equ 0
MenuBarAttrType_visible_count        equ 1
MenuBarAttrType_visible_mask         equ $00000001
MenuBarAttrType_commandPending_shift equ 1
MenuBarAttrType_commandPending_count equ 1
MenuBarAttrType_commandPending_mask  equ $00000002
MenuBarAttrType_insPtEnabled_shift   equ 2
MenuBarAttrType_insPtEnabled_count   equ 1
MenuBarAttrType_insPtEnabled_mask    equ $00000004
MenuBarAttrType_sizeof               equ 2

struct MenuBarType
	barWin.l
	bitsBehind.l
	savedActiveWin.l
	bitsBehindStatus.l
	attr.w
	curMenu.w
	curItem.w
	commandTick.l
	numMenus.w
	menus.l
endstruct


; UI\Progress.h

progressMaxMessage	equ	128
progressMaxTitle	equ	20

struct PrgCallbackData
	stage.w
	textP.l
	textLen.w
	message.l
	error.w
	bitmapId.w
	flags.w
	timeout.l
	barMaxValue.l
	barCurValue.l
	barMessage.l
	barFlags.w
endstruct
;	canceled:1.w
;	showDetails:1.w
;	textChanged:1.w
;	timedOut:1.w

struct ProgressType
	frmP.l
	timeout.l
	flags.w
	error.w
	stage.w
	lastBitmapID.w
	ctlLabel.8
	serviceNameP.l
	lastBarMaxValue.l
	lastBarCurValue.l
	oldDrawWinH.l
	oldActiveWinH.l
	oldFrmP.l
	oldInsPtState.w
	oldInsPtPos.PointType
	textCallback.l
	title.22
endstruct
;	needUpdate:1.w
;	cancel:1.w
;	waitingForOK:1.w
;	showDetails:1.w
;	messageChanged:1.w


; UI\ScrDriver.h
;
;scrMaxLineBytes	equ	32
;
; ScrDisplayModeOperation
scrDisplayModeGetDefaults	equ	0
scrDisplayModeGet		equ	1
scrDisplayModeSetToDefaults	equ	2
scrDisplayModeSet		equ	3
scrDisplayModeGetSupportedDepths	equ	4
scrDisplayModeGetSupportsColor	equ	5
;
;struct ScrBltInfoType
;	op.ScrOperation
;	height.w
;	dstBaseP.l
;	dstRowBytes.l
;	srcBaseP.l
;	srcRowBytes.l
;	leftMask.w
;	rightMask.w
;	midWords.w
;	dstRowDelta.w
;	dstP.l
;	srcRowDelta.w
;	srcP.l
;	patternP.w
;	solidPat.w
;	simple.b
;	pattern.CustomPatternType
;endstruct
;
;struct ScrGlobalsType
;	width.w
;	height.w
;	rowBytes.b
;	baseAddr.l
;	grayPat.CustomPatternType
;	doDrawNotify.b
;	updateR.AbsRectType
;	lastUpdate.l
;endstruct


; UI\ScrDriverNew.h

scrMaxLineBytes	equ	40
scrMaxDepth	equ	2

; ScrDisplayModeOperation
scrDisplayModeGetDefaults		equ	0
scrDisplayModeGet			equ	1
scrDisplayModeSetToDefaults		equ	2
scrDisplayModeSet			equ	3
scrDisplayModeGetSupportedDepths	equ	4
scrDisplayModeGetSupportsColor		equ	5

struct ScrBltInfoType
	op.w
	height.w
	dstBaseP.l
	dstRowBytes.l
	dstDepth.w
	dstShift.w
	dstPixelsInWordZ.w
	forePixels.w
	backPixels.w
	oneBitTableP.l
	srcBaseP.l
	srcRowBytes.l
	srcDepth.w
	srcShift.w
	srcPixelsInWordZ.w
	convSrcP.l
	dynConvSrcP.w	; :1
	patternP.l
	simple.w
	dstP.l
	dstRowDelta.l
	leftMask.w
	rightMask.w
	midWords.w
	srcP.l
	srcRowDelta.l
	forward.w	; :1
	srcBytesInLine.w
endstruct

;struct ScrGlobalsType
;	gDevice.GDeviceType
;	grayPat.8	;CustomPatternType
;	doDrawNotify.w
;	updateR.AbsRectType
;	lastUpdate.l
;	expSrcSize.w
;	expSrcP.l
;endstruct


; UI\ScrollBar.h

; ScrollBarRegionType
sclUpArrow	equ	0
sclDownArrow	equ	1
sclUpPage	equ	2
sclDownPage	equ	3
sclCar		equ	4

ScrollBarAttrType_usable	equ	$0001
ScrollBarAttrType_visible	equ	$0002
ScrollBarAttrType_hilighted	equ	$0004
ScrollBarAttrType_shown		equ	$0008
ScrollBarAttrType_activeRegion	equ	$000F

struct ScrollBarType
	bounds.RectangleType
	id.w
	attr.w
	value.w
	minValue.w
	maxValue.w
	pageSize.w
	penPosInCar.w
	savePos.w
endstruct


; UI\SelDay.h

daySelectorMinYear	equ	firstYear
daySelectorMaxYear	equ	lastYear


; UI\SelTime.h

NumericSpaceChar	equ	$80

struct HMSTime
	hours.b
	minutes.b
	seconds.b
	pad.b
endstruct


; UI\Table.h

tableDefaultColumnSpacing	equ	1
tableNoteIndicatorWidth		equ	7
tableNoteIndicatorHeight	equ	11
tableMaxTextItemSize		equ	255

; tableItemStyles
checkboxTableItem	equ	0
customTableItem		equ	1
dateTableItem		equ	2
labelTableItem		equ	3
numericTableItem	equ	4
popupTriggerTableItem	equ	5
textTableItem		equ	6
textWithNoteTableItem	equ	7
timeTableItem		equ	8
narrowTextTableItem	equ	9

struct TableItemType
	itemType.b
	fontID.b
	intValue.w
	ptr.l
endstruct

struct TableColumnAttrType
	width.w
	unused.w
	editIndicator.w
	usable.w
	spacing.w
	drawCallback.l
	loadDataCallback.l
	saveDataCallback.l
endstruct

struct TableRowAttrType
	id.w
	height.w
	data.l
	reserved1.w
	usable.w
	reserved2.w
	invalid.w
	staticHeight.w
	selectable.w
	reserved3.w
endstruct

TableAttrType_visible_shift  equ 0
TableAttrType_visible_count  equ 1
TableAttrType_visible_mask   equ $00000001
TableAttrType_editable_shift equ 1
TableAttrType_editable_count equ 1
TableAttrType_editable_mask  equ $00000002
TableAttrType_editing_shift  equ 2
TableAttrType_editing_count  equ 1
TableAttrType_editing_mask   equ $00000004
TableAttrType_selected_shift equ 3
TableAttrType_selected_count equ 1
TableAttrType_selected_mask  equ $00000008
TableAttrType_hasScrollBar_shift equ 4
TableAttrType_hasScrollBar_count equ 1
TableAttrType_hasScrollBar_mask  equ $00000010

struct TableType
	id.w
	bounds.RectangleType
	attr.b
	pad.b
	numColumns.w
	numRows.w
	currentRow.w
	currentColumn.w
	topRow.w
	columnAttrs.l
	rowAttrs.l
	items.l
	currentField.FieldType
endstruct


; UI\UICommon.h

strRsc	equ	'tSTR'
ainRsc	equ	'tAIN'
iconType	equ	'tAIB'
bitmapRsc	equ	'Tbmp'
alertRscType	equ	'Talt'
kbdRscType	equ	'tkbd'
MenuRscType	equ	'MBAR'
fontRscType	equ	'NFNT'
verRsc	equ	'tver'
appInfoStringsRsc	equ	'tAIS'

appVersionID	equ	1
appVersionAlternateID	equ	1000
ainID	equ	1000

defaultAppIconBitmap	equ	10000
defaultAppSmallIconBitmap	equ	10001

systemVersionID	equ	10000

palmLogoBitmap	equ	10000
keyboardBackspaceBitmap	equ	10001
keyboardTabBitmap	equ	10002
keyboardReturnBitmap	equ	10003
InformationAlertBitmap	equ	10004
ConfirmationAlertBitmap	equ	10005
WarningAlertBitmap	equ	10006
ErrorAlertBitmap	equ	10007
keyboardShiftBitmap	equ	10008
keyboardCapBitmap	equ	10009

daysOfWeekStrID	equ	10000
dayFullNamesStrID	equ	10001
monthNamesStrID	equ	10002
monthFullNamesStrID	equ	10003
categoryAllStrID	equ	10004
categoryEditStrID	equ	10005
menuCommandStrID	equ	10006
launcherBatteryStrID	equ	10007
systemNameStrID	equ	10008
phoneLookupTitleStrID	equ	10009
phoneLookupAddStrID	equ	10010
phoneLookupFormatStrID	equ	10011

oemProductNameStrID	equ	10012

proStrID	equ	10013
demoStrID	equ	10014

sysSendStatusBeamingStrID	equ	10015
sysSendStatusReceivingStrID	equ	10016

SelectACategoryAlert	equ	10000
; This alert broke 1.0 applications and is now disabled until later.
; It is redefined below (10015).
;#define RemoveCategoryAlert				10001
;#define RemoveCategoryRecordsButton		0
;#define RemoveCategoryNameButton			1
;#define RemoveCategoryCancelButton		2
LowBatteryAlert	equ	10002
VeryLowBatteryAlert	equ	10003
UndoAlert	equ	10004
UndoCancelButton	equ	1

MergeCategoryAlert	equ	10005
MergeCategoryYes	equ	0
MergeCategoryNo	equ	1

privateRecordInfoAlert	equ	10006

ClipboardLimitAlert	equ	10007

CategoryExistsAlert	equ	10012

DeviceFullAlert	equ	10013

categoryAllUsedAlert	equ	10014

RemoveCategoryAlert	equ	10015
RemoveCategoryYes	equ	0
RemoveCategoryNo	equ	1

DemoUnitAlert	equ	10016

NoDataToBeamAlert	equ	10017

sysEditMenuID	equ	10000
sysEditMenuUndoCmd	equ	10000
sysEditMenuCutCmd	equ	10001
sysEditMenuCopyCmd	equ	10002
sysEditMenuPasteCmd	equ	10003
sysEditMenuSelectAllCmd	equ	10004
sysEditMenuSeparator	equ	10005
sysEditMenuKeyboardCmd	equ	10006
sysEditMenuGraffitiCmd	equ	10007

sysKeyboardMenuID	equ	10100
sysKeyboardEditUndoCmd	equ	100
sysKeyboardEditCutCmd	equ	101
sysKeyboardEditCopyCmd	equ	102
sysKeyboardEditPasteCmd	equ	103
sysKeyboardEditSelectAllCmd	equ	104

noteMenuID	equ	10200
noteUndoCmd	equ	10000
noteCutCmd	equ	10001
noteCopyCmd	equ	10002
notePasteCmd	equ	10003
noteSelectAllCmd	equ	10004
noteSeparator	equ	10005
noteKeyboardCmd	equ	10006
noteGraffitiCmd	equ	10007
noteFontCmd	equ	10200
noteTopOfPageCmd	equ	10201
noteBottomOfPageCmd	equ	10202
notePhoneLookupCmd	equ	10203

SystemKeyboardID	equ	10000

CategoriesEditForm	equ	10000
CategoriesEditList	equ	10002
CategoriesEditOKButton	equ	10003
CategoriesEditNewButton	equ	10004
CategoriesEditRenameButton	equ	10005
CategoriesEditDeleteButton	equ	10006

DateSelectorForm	equ	10100
DateSelectorYearLabel	equ	10102
DateSelectorPriorYearButton	equ	10103
DateSelectorNextYearButton	equ	10104
DateSelectorTodayButton	equ	10118
DateSelectorCancelButton	equ	10119
DateSelectorDayGadget	equ	10120
DateSelectorThisWeekButton	equ	10121
DateSelectorThisMonthButton	equ	10122

TimeSelectorForm	equ	10200
TimeSelectorStartTimeButton	equ	10204
TimeSelectorEndTimeButton	equ	10205
TimeSelectorHourList	equ	10206
TimeSelectorMinuteList	equ	10207
TimeSelectorOKButton	equ	10208
TimeSelectorCancelButton	equ	10209
TimeSelectorNoTimeButton	equ	10210

KeyboardForm	equ	10300
KeyboardGadget	equ	10310

HelpForm	equ	10400
HelpField	equ	10402
HelpDoneButton	equ	10403
HelpUpButton	equ	10404
HelpDownButton	equ	10405

FindDialog	equ	10500
FindStrField	equ	10503
FindOKButton	equ	10504

FindResultsDialog	equ	10600
FindResultsMsgLabel	equ	10602
FindResultsTable	equ	10603
FindResultsGoToButton	equ	10604
FindResultsCancelButton	equ	10605
FindResultsMoreButton	equ	10606
FindResultsStopButton	equ	10607

FindResultsSearchingStr	equ	10607
FindResultsMatchesStr	equ	10608
FindResultsNoMatchesStr	equ	10609
FindResultsContinueStr	equ	10610

NoteView	equ	10900
NoteField	equ	10901
NoteDoneButton	equ	10902
NoteSmallFontButton	equ	10903
NoteLargeFontButton	equ	10904
NoteDeleteButton	equ	10905
NoteUpButton	equ	10906
NoteDownButton	equ	10907
NoteScrollBar	equ	10908
NoteFontGroup	equ	1
noteViewMaxLength	equ	4096

aboutDialog	equ	11000
aboutNameLabel	equ	11001
aboutVersionLabel	equ	11002
aboutErrorStr	equ	11003

categoryNewNameDialog	equ	11100
categoryNewNameField	equ	11103
categoryNewNameOKButton	equ	11104

graffitiReferenceDialog	equ	11200
graffitiReferenceDoneButton	equ	11202
graffitiReferenceUpButton	equ	11203
graffitiReferenceDownButton	equ	11204
graffitiReferenceFirstBitmap	equ	11205

netSerStringList	equ	11300

netSerProgressFrm	equ	11300
netSerProgressLabelStage	equ	11302
netSerProgressBtnCancel	equ	11303
netSerPictPhone	equ	11300
netSerPictHandshake	equ	11301
netSerPictBook	equ	11302

netSerPromptFrm	equ	11400
netSerPromptAsk	equ	11402
netSerPromptField	equ	11403
netSerPromptBtnOK	equ	11404
netSerPromptBtnCancel	equ	11405

launcherDialog	equ	11500
launcherGadget	equ	11501

prgStringList	equ	11600
prgProgressFrm	equ	11600
prgProgressLabelStage	equ	11602
prgProgressBtnCancel	equ	11603
prgPictPhone	equ	11620
prgPictHandshake	equ	11621
prgPictBook	equ	11622
prgPictError	equ	11623

prgBeamSend1	equ	11640
prgBeamSend2	equ	11641
prgBeamRec1	equ	11642
prgBeamRec2	equ	11643
prgBeamPrepare1	equ	11644
prgBeamPrepare2	equ	11645
prgBeamIdle	equ	11646

exgPrgStringList	equ	11650
exgStrIndexOK	equ	1
exgStrIndexCancelling	equ	2
exgStrIndexError	equ	3
exgStrIndexInitializing	equ	4
exgStrIndexStarting	equ	5
exgStrIndexSearching	equ	6
exgStrIndexConnected	equ	7
exgStrIndexSending	equ	8
exgStrIndexReceiving	equ	9
exgStrIndexDisconnecting	equ	10
exgStrIndexWaitingSender	equ	11
exgStrIndexPreparing	equ	12
exgStrIndexAccepting	equ	13
exgStrIndexInterrupted	equ	14

ExchangeForm	equ	11700
ExchangeOKButton	equ	11701
ExchangeCancelButton	equ	11702
ExchangeIconBitMap	equ	11704
ExchangeMessageField	equ	11703
ExchangeQuestionString	equ	11710
ExchangeUnnamedString	equ	11711
ExchangeIrBeamString	equ	11712
ExchangeLowBatteryAlert	equ	11720
ExchangeReceiveDisabledAlert	equ	11730
ExchangeIrUnsupportedAlert	equ	11740
ExchangeNoLibraryAlert	equ	11750

FontSelectorForm	equ	11900
FontSelector1Button	equ	11903
FontSelector2Button	equ	11904
FontSelector3Button	equ	11905
FontSelectorOKButton	equ	11906
FontSelectorCancelButton	equ	11907
FontSelectorFontGroup	equ	1

CustomAlertDialog	equ	12000
CustomAlertBitmap	equ	12002
CustomAlertField	equ	12003
CustomAlertFirstButton	equ	12004


; UI\UIGlobals.h

UIDefNumSysFonts	equ	8
UIDefNumAppFonts	equ	4

eventQueueSize	equ	10

struct UIGlobalsType
	activeWindow.l
	displayWindow.l
	drawWindow.l
	firstWindow.l
	exitWindowID.l
	enterWindowID.l
	exitedWindowID.l
	gState.GraphicStateType
	eventQ.l
	eventQIndex.w
	eventQLength.w
	lastScreenX.w
	lastScreenY.w
	lastPenDown.b
	Pad.b
	needNullTickCount.l
	uiCurrentFontPtr.l
	FontPtr.l
	uiSysFontTablePtr.l
	uiAppFontTablePtr.l
	uiNumSysFonts.w
	uiNumAppFonts.w
	uiUnused1.l
	uiUnused2.l
	uiCurrentFontID.b
	pad2.b
	currentForm.l
	insPtIsEnabled.b
	insPtOn.b
	insPtLoc.PointType
	insPtHeight.w
	insPtLastTick.l
	insPtBitsBehind.l
	clipboard.18
	uiCurrentMenu.l
	uiCurrentMenuRscID.w
	undoGlobals.FieldUndoType
	gsiState.b
	gsiIsEnabled.b
	gsiLocation.PointType
	uiDecimalSeparator.b
endstruct

; Custom code here

; Custom Library calls for the Pacific MicroInstrument PMI-12 ADC Springboard
; defined in PmiLib1.h (changed PmiLibTrap to sysLibTrap for Jump)
; added by Rod Montrose 11/02/01
;
; standard Library functions
sysLibTrapPMIOpen     		equ sysLibTrapOpen
sysLibTrapPMIOpenCallBack 	equ sysLibTrapOpen
sysLibTrapPMIOpenCallBack2 	equ sysLibTrapOpen
sysLibTrapPMIClose    		equ sysLibTrapClose
sysLibTrapPMISleep    		equ sysLibTrapSleep
sysLibTrapPMIWake     		equ sysLibTrapWake
; custom API Library functions here
sysLibTrapPMIGetLibAPIVersion    equ sysLibTrapCustom
sysLibTrapPMIPowerADC            equ sysLibTrapCustom+1
sysLibTrapPMIGetFirmwareVersion  equ sysLibTrapCustom+2
sysLibTrapPMIStartADC            equ sysLibTrapCustom+3
sysLibTrapPMIStopADC             equ sysLibTrapCustom+4
sysLibTrapPMIGet                 equ sysLibTrapCustom+5
sysLibTrapPMISet                 equ sysLibTrapCustom+6
sysLibTrapPMIReadBuffer		 equ sysLibTrapCustom+7
sysLibTrapPMIReadBufferByteArray equ sysLibTrapCustom+7
sysLibTrapPMIReadStreamFile      equ sysLibTrapCustom+8
sysLibTrapPMIReadStreamFileByteArray equ sysLibTrapCustom+8
sysLibTrapPMIReadTriggerFile     equ sysLibTrapCustom+9
sysLibTrapPMIReadTriggerFileByteArray  equ sysLibTrapCustom+9
sysLibTrapPMIReadFile            equ sysLibTrapCustom+10
sysLibTrapPMISaveFile            equ sysLibTrapCustom+11

; Custom Library calls for the Symbol ScanMgr library.
; added by Rod Montrose 11/09/02. Based on GCC ScanMgrLib.h file
; from john@acaciacons.com.au
;
sysLibTrapScanMgrLibOpen     		equ 	sysLibTrapOpen
sysLibTrapScanMgrLibClose    		equ 	sysLibTrapClose
sysLibTrapScanMgrLibSleep    		equ 	sysLibTrapSleep
sysLibTrapScanMgrLibWake     		equ 	sysLibTrapWake
; custom API Library functions here
sysLibTrapScanMgrLibGetLibAPIVersion	equ	sysLibTrapCustom	; $A805
sysLibTrapScanKernGetDecodedData	equ	sysLibTrapCustom+1	; $A806
sysLibTrapScanKernCommandSend		equ	sysLibTrapCustom+2	; $A807
sysLibTrapScanKernSendParams		equ	sysLibTrapCustom+3	; $A808
sysLibTrapScanKernParamPacket		equ	sysLibTrapCustom+4	; $A809
sysLibTrapScanSetBarcodeEnable		equ	sysLibTrapCustom+4	; $A809
sysLibTrapScanSetTriggeringModes	equ	sysLibTrapCustom+4	; $A809
sysLibTrapScanGetExtendedDecodedData	equ	sysLibTrapCustom+4	; $A809
sysLibTrapScanKernParamRequest		equ	sysLibTrapCustom+5	; $A80A
sysLibTrapScanGetBarcodeEnabled		equ	sysLibTrapCustom+5	; $A80A
sysLibTrapScanKernParamRequestMultiple	equ	sysLibTrapCustom+6	; $A80B
sysLibTrapScanKernGetParam		equ	sysLibTrapCustom+7	; $A80C
sysLibTrapScanKernParamBatchIsRoom	equ	sysLibTrapCustom+8	; $A80D
sysLibTrapScanKernGetAllParams		equ	sysLibTrapCustom+9	; $A80E
sysLibTrapScanKernCmdLED		equ	sysLibTrapCustom+10	; $A80F
sysLibTrapScanKernBeep			equ	sysLibTrapCustom+11	; $A810
sysLibTrapScanKernSetBeepParams		equ	sysLibTrapCustom+12	; $A811
sysLibTrapScanKernGetBeepParams		equ	sysLibTrapCustom+13	; $A812
sysLibTrapScanKernDecInitDecoder	equ	sysLibTrapCustom+14	; $A813
sysLibTrapScanKernDecKillDecoder	equ	sysLibTrapCustom+15	; $A814
sysLibTrapScanKernSetLocalParam		equ	sysLibTrapCustom+16	; $A815
sysLibTrapScanKernGetLocalParam		equ	sysLibTrapCustom+17	; $A816
sysLibTrapScanKernGetVersionString	equ	sysLibTrapCustom+18	; $A817
sysLibTrapScanGetPrefixSuffixValue	equ	sysLibTrapCustom+18	; $A818

; PO5 High-Density traps
sysTrapHighDensityDispatch				equ	41964

;; High-Density trap selectors
HDSelectorBmpGetNextBitmapAnyDensity	equ	0
HDSelectorBmpGetVersion					equ	1
HDSelectorBmpGetCompressionType			equ	2
HDSelectorBmpGetDensity					equ	3
HDSelectorBmpSetDensity					equ	4
HDSelectorBmpGetTransparentValue		equ	5
HDSelectorBmpSetTransparentValue		equ	6
HDSelectorBmpCreateBitmapV3				equ	7
HDSelectorWinSetCoordinateSystem		equ	8
HDSelectorWinGetCoordinateSystem		equ	9
HDSelectorWinScalePoint					equ	10
HDSelectorWinUnscalePoint				equ	11
HDSelectorWinScaleRectangle				equ	12
HDSelectorWinUnscaleRectangle			equ	13
HDSelectorWinScreenGetAttribute			equ	14
HDSelectorWinPaintTiledBitmap			equ	15
HDSelectorWinGetSupportedDensity		equ	16
HDSelectorEvtGetPenNative				equ	17
HDSelectorWinScaleCoord					equ	18
HDSelectorWinUnscaleCoord				equ	19
HDSelectorWinPaintRoundedRectangleFrame	equ 20
HDSelectorWinSetScalingMode				equ	21
HDSelectorWinGetScalingMode				equ	22


; from HostControl.h

	; Host information selectors

hostSelectorGetHostVersion		equ	$0100
hostSelectorGetHostID			equ	$0101
hostSelectorGetHostPlatform		equ	$0102
hostSelectorIsSelectorImplemented	equ	$0103
hostSelectorGestalt			equ	$0104
hostSelectorIsCallingTrap		equ	$0105


	; Profiler selectors

hostSelectorProfileInit			equ	$0200
hostSelectorProfileStart		equ	$0201
hostSelectorProfileStop			equ	$0202
hostSelectorProfileDump			equ	$0203
hostSelectorProfileCleanup		equ	$0204
hostSelectorProfileDetailFn		equ	$0205


	; Std C Library wrapper selectors

hostSelectorErrNo			equ	$0300

hostSelectorFClose			equ	$0301
hostSelectorFEOF			equ	$0302
hostSelectorFError			equ	$0303
hostSelectorFFlush			equ	$0304
hostSelectorFGetC			equ	$0305
hostSelectorFGetPos			equ	$0306
hostSelectorFGetS			equ	$0307
hostSelectorFOpen			equ	$0308
hostSelectorFPrintF			equ	$0309		/* Floating point not yet supported in Poser */
hostSelectorFPutC			equ	$030A
hostSelectorFPutS			equ	$030B
hostSelectorFRead			equ	$030C
hostSelectorRemove			equ	$030D
hostSelectorRename			equ	$030E
hostSelectorFReopen			equ	$030F		/* Not yet implemented in Poser */
hostSelectorFScanF			equ	$0310		/* Not yet implemented */
hostSelectorFSeek			equ	$0311
hostSelectorFSetPos			equ	$0312
hostSelectorFTell			equ	$0313
hostSelectorFWrite			equ	$0314
hostSelectorTmpFile			equ	$0315
hostSelectorTmpNam			equ	$0316

hostSelectorGetEnv			equ	$0317

hostSelectorMalloc			equ	$0318
hostSelectorRealloc			equ	$0319
hostSelectorFree			equ	$031A

	; time.h wrappers
hostSelectorAscTime			equ	$0370
hostSelectorClock			equ	$0371
hostSelectorCTime			equ	$0372
hostSelectorGMTime			equ	$0374
hostSelectorLocalTime			equ	$0375
hostSelectorMkTime			equ	$0376
hostSelectorStrFTime			equ	$0377
hostSelectorTime			equ	$0378

	; dirent.h wrappers
hostSelectorOpenDir			equ	$0380
hostSelectorReadDir			equ	$0381
hostSelectorCloseDir			equ	$0383

	; fcntl.h wrappers

	; unistd.h wrappers
hostSelectorRmDir			equ	$0394
hostSelectorTruncate			equ	$03A7

	; sys/stat.h wrappers
hostSelectorMkDir			equ	$03AA
hostSelectorStat			equ	$03AB

	; sys/time.h wrappers
hostSelectorUTime			equ	$03AE

	; DOS attr 
hostSelectorGetFileAttr			equ	$03AF
hostSelectorSetFileAttr			equ	$03B0

	; Gremlin selectors

hostSelectorGremlinIsRunning		equ	$0400
hostSelectorGremlinNumber		equ	$0401
hostSelectorGremlinCounter		equ	$0402
hostSelectorGremlinLimit		equ	$0403
hostSelectorGremlinNew			equ	$0404


	; Database selectors

hostSelectorImportFile			equ	$0500
hostSelectorExportFile			equ	$0501

hostSelectorExgLibOpen			equ	$0580
hostSelectorExgLibClose			equ	$0581
hostSelectorExgLibSleep			equ	$0582
hostSelectorExgLibWake			equ	$0583
hostSelectorExgLibHandleEvent		equ	$0584
hostSelectorExgLibConnect		equ	$0585
hostSelectorExgLibAccept		equ	$0586
hostSelectorExgLibDisconnect		equ	$0587
hostSelectorExgLibPut			equ	$0588
hostSelectorExgLibGet			equ	$0589
hostSelectorExgLibSend			equ	$058A
hostSelectorExgLibReceive		equ	$058B
hostSelectorExgLibControl		equ	$058C
hostSelectorExgLibRequest		equ	$058D


	; Preferences selectors

hostSelectorGetPreference		equ	$0600
hostSelectorSetPreference		equ	$0601


	; Logging selectors

hostSelectorLogFile			equ	$0700
hostSelectorSetLogFileSize		equ	$0701


	; RPC selectors

hostSelectorSessionCreate		equ	$0800		/* Not yet implemented in Poser */
hostSelectorSessionOpen			equ	$0801		/* Not yet implemented in Poser */
hostSelectorSessionClose		equ	$0802
hostSelectorSessionQuit			equ	$0803
hostSelectorSignalSend			equ	$0804
hostSelectorSignalWait			equ	$0805
hostSelectorSignalResume		equ	$0806


	; External tracing tool support

hostSelectorTraceInit			equ	$0900
hostSelectorTraceClose			equ	$0901
hostSelectorTraceOutputT		equ	$0902
hostSelectorTraceOutputTL		equ	$0903
hostSelectorTraceOutputVT		equ	$0904
hostSelectorTraceOutputVTL		equ	$0905
hostSelectorTraceOutputB		equ	$0906



	; File choosing support

hostSelectorGetFile			equ	$0B00
hostSelectorPutFile			equ	$0B01
hostSelectorGetDirectory		equ	$0B02

hostSelectorLastTrapNumber		equ	$0BFF

	; from ExpansionMgr.c
expInit					equ	0
expSlotDriverInstall	equ	1
expSlotDriverRemove		equ	2
expSlotLibFind			equ	3
expSlotRegister			equ	4
expSlotUnregister		equ	5
expCardInserted			equ	6
expCardRemoved			equ	7
expCardPresent			equ	8
expCardInfo				equ	9
expSlotEnumerate		equ	10
expCardGetSerialPort	equ	11

    ; VFS defines
sysTrapVFSMgr   equ 	sysTrapSysReserved3

vfsTrapInit	equ						0
vfsTrapCustomControl	equ			1

vfsTrapFileCreate	equ				2
vfsTrapFileOpen	equ					3
vfsTrapFileClose	equ				4
vfsTrapFileReadData	equ			5
vfsTrapFileRead	equ					6
vfsTrapFileWrite	equ				7
vfsTrapFileDelete	equ				8
vfsTrapFileRename	equ				9
vfsTrapFileSeek	equ					10
vfsTrapFileEOF	equ					11
vfsTrapFileTell	equ					12
vfsTrapFileResize	equ				13
vfsTrapFileGetAttributes	equ		14
vfsTrapFileSetAttributes	equ		15
vfsTrapFileGetDate	equ				16
vfsTrapFileSetDate	equ				17
vfsTrapFileSize	equ					18

vfsTrapDirCreate	equ				19
vfsTrapDirEntryEnumerate	equ		20
vfsTrapGetDefaultDirectory	equ	21
vfsTrapRegisterDefaultDirectory	equ	22
vfsTrapUnregisterDefaultDirectory	equ	23

vfsTrapVolumeFormat	equ			24
vfsTrapVolumeMount	equ				25
vfsTrapVolumeUnmount	equ			26
vfsTrapVolumeEnumerate	equ		27
vfsTrapVolumeInfo	equ				28
vfsTrapVolumeGetLabel	equ			29
vfsTrapVolumeSetLabel	equ			30
vfsTrapVolumeSize	equ				31

vfsTrapInstallFSLib	equ			32
vfsTrapRemoveFSLib	equ				33
vfsTrapImportDatabaseFromFile	equ	34
vfsTrapExportDatabaseToFile	equ		35
vfsTrapFileDBGetResource	equ		36
vfsTrapFileDBInfo	equ				37
vfsTrapFileDBGetRecord	equ		38

vfsTrapImportDatabaseFromFileCustom	equ	39
vfsTrapExportDatabaseToFileCustom	equ	40

    ; Handspring defines
sysTrapHsSelector	equ	sysTrapSysReserved4

hsSelInfo	equ	0
hsSelPrvInit	equ	1
hsSelPrvCallSafely	equ	2
hsSelPrvCallSafelyNewStack	equ	3
hsSelDatabaseCopy	equ	4
hsSelExtKeyboardEnable	equ	5
hsSelCardAttrGet	equ	6
hsSelCardAttrSet	equ	7
hsSelCardEventPost	equ	8
hsSelPrvErrCatchListP	equ	9
hsSelPrefGet	equ	10
hsSelPrefSet	equ	11
hsSelDmGetNextDBByTypeCreator	equ	12
hsSelDmGetNextDBInit	equ	13
hsSelCardHdrUpdate	equ	14
hsSelAppEventHandlerSet	equ	15
hsSelAppEventPost	equ	16
hsSelUsbCommStatePtr	equ	17
hsSelCardPatchInstall	equ	18
hsSelCardPatchRemove	equ	19
hsSelEvtResetAutoOffTimer	equ	20
hsSelDmDatabaseUniqueIDSeed	equ	21
hsSelAboutHandspringApp	equ	22
hsSelDmDatabaseIsOpen	equ	23
hsSelDmDatabaseIsProtected	equ	24
hsSelDlkForceSlowSync	equ	25
hsSelLast	equ	26

    ; Sony defines
HRTrapGetAPIVersion     equ 43013
HRTrapWinClipRectangle  equ 43014
HRTrapWinCopyRectangle  equ 43015
HRTrapWinCreateBitmapWindow     equ 43016
HRTrapWinCreateOffscreenWindow  equ 43017
HRTrapWinCreateWindow       equ 43018
HRTrapWinDisplayToWindowPt  equ 43019
HRTrapWinDrawBitmap     equ 43020
HRTrapWinDrawChar       equ 43021
HRTrapWinDrawChars      equ 43022
HRTrapWinDrawGrayLine   equ 43023
HRTrapWinDrawGrayRectangleFrame equ 43024
HRTrapWinDrawInvertedChars      equ 43025
HRTrapWinDrawLine       equ 43026
HRTrapWinDrawPixel      equ 43027
HRTrapWinDrawRectangle  equ 43028
HRTrapWinDrawRectangleFrame equ 43029
HRTrapWinDrawTruncChars     equ 43030
HRTrapWinEraseChars     equ 43031
HRTrapWinEraseLine      equ 43032
HRTrapWinErasePixel     equ 43033
HRTrapWinEraseRectangle equ 43034
HRTrapWinEraseRectangleFrame equ 43035
HRTrapWinFillLine       equ 43036
HRTrapWinFillRectangle  equ 43037
HRTrapWinGetClip        equ 43038
HRTrapWinGetDisplayExtent   equ 43039
HRTrapWinGetFramesRectangle equ 43040
HRTrapWinGetPixel       equ 43041
HRTrapWinGetWindowBounds    equ 43042
HRTrapWinGetWindowExtent    equ 43043
HRTrapWinGetWindowFrameRect equ 43044
HRTrapWinInvertChars    equ 43045
HRTrapWinInvertLine     equ 43046
HRTrapWinInvertPixel    equ 43047
HRTrapWinInvertRectangle equ 43048
HRTrapWinInvertRectangleFrame equ 43049
HRTrapWinPaintBitmap    equ 43050
HRTrapWinPaintChar      equ 43051
HRTrapWinPaintChars     equ 43052
HRTrapWinPaintLine      equ 43053
HRTrapWinPaintLines     equ 43054
HRTrapWinPaintPixel     equ 43055
HRTrapWinPaintPixels    equ 43056
HRTrapWinPaintRectangle equ 43057
HRTrapWinPaintRectangleFrame equ 43058
HRTrapWinRestoreBits    equ 43059
HRTrapWinSaveBits       equ 43060
HRTrapWinScreenMode     equ 43061
HRTrapWinScrollRectangle equ 43062
HRTrapWinSetClip        equ 43063
HRTrapWinSetWindowBounds equ 43064
HRTrapWinWindowToDisplayPt equ 43065
HRTrapBmpBitsSize       equ 43066
HRTrapBmpSize           equ 43067
HRTrapBmpCreate         equ 43068
HRTrapFntGetFont        equ 43069
HRTrapFntSetFont        equ 43070
HRTrapFontSelect        equ 43071
HRTrapSystem            equ 43072
HRTrapWinGetPixelRGB    equ 43073
HRTrapGetInfo           equ 43074
HRTrapFntBaseLine       equ 43075
HRTrapFntCharHeight     equ 43076
HRTrapFntLineHeight     equ 43077
HRTrapFntAverageCharWidth equ 43078
HRTrapFntCharWidth      equ 43079
HRTrapFntWCharWidth     equ 43080
HRTrapFntCharsWidth     equ 43081
HRTrapFntWidthToOffset  equ 43082
HRTrapFntCharsInWidth   equ 43083
HRTrapFntDescenderHeight equ 43084
HRTrapFntLineWidth      equ 43085
HRTrapFntWordWrap       equ 43086
HRTrapFntWordWrapReverseNLines equ 43087
HRTrapFntGetScrollValues equ 43088


	list 1		;renable listing


