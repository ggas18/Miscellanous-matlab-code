#include "__cf_model1.h"
#ifndef RTW_HEADER_model1_h_
#define RTW_HEADER_model1_h_
#include <stddef.h>
#include <string.h>
#include "rtw_modelmap.h"
#ifndef model1_COMMON_INCLUDES_
#define model1_COMMON_INCLUDES_
#include <stdlib.h>
#include "rtwtypes.h"
#include "simtarget/slSimTgtSigstreamRTW.h"
#include "simtarget/slSimTgtSlioCoreRTW.h"
#include "simtarget/slSimTgtSlioClientsRTW.h"
#include "sigstream_rtw.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "raccel.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "rt_logging.h"
#include "dt_info.h"
#include "ext_work.h"
#endif
#include "model1_types.h"
#include "multiword_types.h"
#include "rt_defines.h"
#include "rtGetInf.h"
#include "rt_nonfinite.h"
#define MODEL_NAME model1
#define NSAMPLE_TIMES (3) 
#define NINPUTS (0)       
#define NOUTPUTS (0)     
#define NBLOCKIO (5) 
#define NUM_ZC_EVENTS (0) 
#ifndef NCSTATES
#define NCSTATES (1)   
#elif NCSTATES != 1
#error Invalid specification of NCSTATES defined in compiler command
#endif
#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm) (*rt_dataMapInfoPtr)
#endif
#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val) (rt_dataMapInfoPtr = &val)
#endif
#ifndef IN_RACCEL_MAIN
#endif
typedef struct { real_T iqq3clhsk0 ; real_T n1zevogb2y ; real_T nlkxmku4j5 ;
real_T nxe5wrpe4q ; } B ; typedef struct { real_T oet0hjbro1 ; real_T
dqzs3y0may ; real_T dbzs3mndal ; real_T oqhyxgox34 ; struct { void *
LoggedData ; } aeulygmhie ; int_T mvhlkd2zh3 ; } DW ; typedef struct { real_T
doz0yv1odz ; } X ; typedef struct { real_T doz0yv1odz ; } XDot ; typedef
struct { boolean_T doz0yv1odz ; } XDis ; typedef struct { real_T doz0yv1odz ;
} CStateAbsTol ; typedef struct { real_T aph3mfws1h ; } ZCV ; typedef struct
{ rtwCAPI_ModelMappingInfo mmi ; } DataMapInfo ; struct P_ { real_T R [ 2 ] ;
real_T S [ 2 ] ; real_T T [ 2 ] ; real_T Gp_A ; real_T Gp_C ; real_T
Step1_Time ; real_T Step1_Y0 ; real_T Step1_YFinal ; real_T SR_InitialStates
; real_T Step_Time ; real_T Step_Y0 ; real_T Step_YFinal ; real_T
TR_InitialStates ; } ; extern const char * RT_MEMORY_ALLOCATION_ERROR ;
extern B rtB ; extern X rtX ; extern DW rtDW ; extern P rtP ; extern const
rtwCAPI_ModelMappingStaticInfo * model1_GetCAPIStaticMap ( void ) ; extern
SimStruct * const rtS ; extern const int_T gblNumToFiles ; extern const int_T
gblNumFrFiles ; extern const int_T gblNumFrWksBlocks ; extern rtInportTUtable
* gblInportTUtables ; extern const char * gblInportFileName ; extern const
int_T gblNumRootInportBlks ; extern const int_T gblNumModelInputs ; extern
const int_T gblInportDataTypeIdx [ ] ; extern const int_T gblInportDims [ ] ;
extern const int_T gblInportComplex [ ] ; extern const int_T
gblInportInterpoFlag [ ] ; extern const int_T gblInportContinuous [ ] ;
extern const int_T gblParameterTuningTid ; extern size_t gblCurrentSFcnIdx ;
extern size_t * gblChildIdxToInfoIdx ; extern DataMapInfo * rt_dataMapInfoPtr
; extern rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr ; void MdlOutputs (
int_T tid ) ; void MdlOutputsParameterSampleTime ( int_T tid ) ; void
MdlUpdate ( int_T tid ) ; void MdlTerminate ( void ) ; void
MdlInitializeSizes ( void ) ; void MdlInitializeSampleTimes ( void ) ;
SimStruct * raccel_register_model ( void ) ;
#endif
