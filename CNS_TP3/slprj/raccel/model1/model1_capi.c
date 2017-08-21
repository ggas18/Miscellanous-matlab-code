#include "__cf_model1.h"
#include "rtw_capi.h"
#ifdef HOST_CAPI_BUILD
#include "model1_capi_host.h"
#define sizeof(s) ((size_t)(0xFFFF))
#undef rt_offsetof
#define rt_offsetof(s,el) ((uint16_T)(0xFFFF))
#define TARGET_CONST
#define TARGET_STRING(s) (s)    
#else
#include "builtin_typeid_types.h"
#include "model1.h"
#include "model1_capi.h"
#include "model1_private.h"
#ifdef LIGHT_WEIGHT_CAPI
#define TARGET_CONST                  
#define TARGET_STRING(s)               (NULL)                    
#else
#define TARGET_CONST                   const
#define TARGET_STRING(s)               (s)
#endif
#endif
static const rtwCAPI_Signals rtBlockSignals [ ] = { { 0 , 0 , TARGET_STRING (
"model1/Step1" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 1 , 0 ,
TARGET_STRING ( "model1/Sum" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 1 } ,
{ 2 , 0 , TARGET_STRING ( "model1/Sum1" ) , TARGET_STRING ( "" ) , 0 , 0 , 0
, 0 , 2 } , { 3 , 0 , TARGET_STRING ( "model1/G(p)" ) , TARGET_STRING ( "" )
, 0 , 0 , 0 , 0 , 2 } , { 0 , 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 , 0 , 0 } }
; static const rtwCAPI_BlockParameters rtBlockParameters [ ] = { { 4 ,
TARGET_STRING ( "model1/Step" ) , TARGET_STRING ( "Time" ) , 0 , 0 , 0 } , {
5 , TARGET_STRING ( "model1/Step" ) , TARGET_STRING ( "Before" ) , 0 , 0 , 0
} , { 6 , TARGET_STRING ( "model1/Step" ) , TARGET_STRING ( "After" ) , 0 , 0
, 0 } , { 7 , TARGET_STRING ( "model1/Step1" ) , TARGET_STRING ( "Time" ) , 0
, 0 , 0 } , { 8 , TARGET_STRING ( "model1/Step1" ) , TARGET_STRING ( "Before"
) , 0 , 0 , 0 } , { 9 , TARGET_STRING ( "model1/Step1" ) , TARGET_STRING (
"After" ) , 0 , 0 , 0 } , { 10 , TARGET_STRING ( "model1/G(p)" ) ,
TARGET_STRING ( "A" ) , 0 , 0 , 0 } , { 11 , TARGET_STRING ( "model1/G(p)" )
, TARGET_STRING ( "C" ) , 0 , 0 , 0 } , { 12 , TARGET_STRING ( "model1/S//R"
) , TARGET_STRING ( "InitialStates" ) , 0 , 0 , 0 } , { 13 , TARGET_STRING (
"model1/T//R" ) , TARGET_STRING ( "InitialStates" ) , 0 , 0 , 0 } , { 0 , (
NULL ) , ( NULL ) , 0 , 0 , 0 } } ; static const rtwCAPI_ModelParameters
rtModelParameters [ ] = { { 14 , TARGET_STRING ( "R" ) , 0 , 1 , 0 } , { 15 ,
TARGET_STRING ( "S" ) , 0 , 1 , 0 } , { 16 , TARGET_STRING ( "T" ) , 0 , 1 ,
0 } , { 0 , ( NULL ) , 0 , 0 , 0 } } ;
#ifndef HOST_CAPI_BUILD
static void * rtDataAddrMap [ ] = { & rtB . n1zevogb2y , & rtB . nxe5wrpe4q ,
& rtB . nlkxmku4j5 , & rtB . iqq3clhsk0 , & rtP . Step_Time , & rtP . Step_Y0
, & rtP . Step_YFinal , & rtP . Step1_Time , & rtP . Step1_Y0 , & rtP .
Step1_YFinal , & rtP . Gp_A , & rtP . Gp_C , & rtP . SR_InitialStates , & rtP
. TR_InitialStates , & rtP . R [ 0 ] , & rtP . S [ 0 ] , & rtP . T [ 0 ] , }
; static int32_T * rtVarDimsAddrMap [ ] = { ( NULL ) } ;
#endif
static TARGET_CONST rtwCAPI_DataTypeMap rtDataTypeMap [ ] = { { "double" ,
"real_T" , 0 , 0 , sizeof ( real_T ) , SS_DOUBLE , 0 , 0 } } ;
#ifdef HOST_CAPI_BUILD
#undef sizeof
#endif
static TARGET_CONST rtwCAPI_ElementMap rtElementMap [ ] = { { ( NULL ) , 0 ,
0 , 0 , 0 } , } ; static const rtwCAPI_DimensionMap rtDimensionMap [ ] = { {
rtwCAPI_SCALAR , 0 , 2 , 0 } , { rtwCAPI_VECTOR , 2 , 2 , 0 } } ; static
const uint_T rtDimensionArray [ ] = { 1 , 1 , 1 , 2 } ; static const real_T
rtcapiStoredFloats [ ] = { 0.0 , 1.0 , 0.03 } ; static const rtwCAPI_FixPtMap
rtFixPtMap [ ] = { { ( NULL ) , ( NULL ) , rtwCAPI_FIX_RESERVED , 0 , 0 , 0 }
, } ; static const rtwCAPI_SampleTimeMap rtSampleTimeMap [ ] = { { ( const
void * ) & rtcapiStoredFloats [ 0 ] , ( const void * ) & rtcapiStoredFloats [
1 ] , 1 , 0 } , { ( const void * ) & rtcapiStoredFloats [ 2 ] , ( const void
* ) & rtcapiStoredFloats [ 0 ] , 2 , 0 } , { ( const void * ) &
rtcapiStoredFloats [ 0 ] , ( const void * ) & rtcapiStoredFloats [ 0 ] , 0 ,
0 } } ; static rtwCAPI_ModelMappingStaticInfo mmiStatic = { { rtBlockSignals
, 4 , ( NULL ) , 0 , ( NULL ) , 0 } , { rtBlockParameters , 10 ,
rtModelParameters , 3 } , { ( NULL ) , 0 } , { rtDataTypeMap , rtDimensionMap
, rtFixPtMap , rtElementMap , rtSampleTimeMap , rtDimensionArray } , "float"
, { 706296214U , 3383841688U , 18818306U , 1871978997U } , ( NULL ) , 0 , 0 }
; const rtwCAPI_ModelMappingStaticInfo * model1_GetCAPIStaticMap ( ) { return
& mmiStatic ; }
#ifndef HOST_CAPI_BUILD
void model1_InitializeDataMapInfo ( ) { rtwCAPI_SetVersion ( ( *
rt_dataMapInfoPtr ) . mmi , 1 ) ; rtwCAPI_SetStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , & mmiStatic ) ; rtwCAPI_SetLoggingStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ; rtwCAPI_SetDataAddressMap ( ( *
rt_dataMapInfoPtr ) . mmi , rtDataAddrMap ) ; rtwCAPI_SetVarDimsAddressMap (
( * rt_dataMapInfoPtr ) . mmi , rtVarDimsAddrMap ) ;
rtwCAPI_SetInstanceLoggingInfo ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArray ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( ( * rt_dataMapInfoPtr ) . mmi , 0 ) ; }
#else
#ifdef __cplusplus
extern "C" {
#endif
void model1_host_InitializeDataMapInfo ( model1_host_DataMapInfo_T * dataMap
, const char * path ) { rtwCAPI_SetVersion ( dataMap -> mmi , 1 ) ;
rtwCAPI_SetStaticMap ( dataMap -> mmi , & mmiStatic ) ;
rtwCAPI_SetDataAddressMap ( dataMap -> mmi , NULL ) ;
rtwCAPI_SetVarDimsAddressMap ( dataMap -> mmi , NULL ) ; rtwCAPI_SetPath (
dataMap -> mmi , path ) ; rtwCAPI_SetFullPath ( dataMap -> mmi , NULL ) ;
rtwCAPI_SetChildMMIArray ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( dataMap -> mmi , 0 ) ; }
#ifdef __cplusplus
}
#endif
#endif
