/* This file was generated by upb_generator from the input file:
 *
 *     udpa/annotations/versioning.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#include <stddef.h>
#include "upb/generated_code_support.h"
#include "udpa/annotations/versioning.upb_minitable.h"
#include "google/protobuf/descriptor.upb_minitable.h"

// Must be last.
#include "upb/port/def.inc"

static const upb_MiniTableField udpa_annotations_VersioningAnnotation__fields[1] = {
  {1, 8, 0, kUpb_NoSub, 9, (int)kUpb_FieldMode_Scalar | ((int)kUpb_FieldRep_StringView << kUpb_FieldRep_Shift)},
};

const upb_MiniTable udpa__annotations__VersioningAnnotation_msg_init = {
  NULL,
  &udpa_annotations_VersioningAnnotation__fields[0],
  UPB_SIZE(16, 24), 1, kUpb_ExtMode_NonExtendable, 1, UPB_FASTTABLE_MASK(8), 0,
  UPB_FASTTABLE_INIT({
    {0x0000000000000000, &_upb_FastDecoder_DecodeGeneric},
    {0x000800003f00000a, &upb_pss_1bt},
  })
};

static const upb_MiniTable *messages_layout[1] = {
  &udpa__annotations__VersioningAnnotation_msg_init,
};

const upb_MiniTableExtension udpa_annotations_versioning_ext = {
  {7881811, 0, 0, 0, 11, (int)kUpb_FieldMode_Scalar | (int)kUpb_LabelFlags_IsExtension | ((int)kUpb_FieldRep_8Byte << kUpb_FieldRep_Shift)},
  &google__protobuf__MessageOptions_msg_init,
  {.UPB_PRIVATE(submsg) = &udpa__annotations__VersioningAnnotation_msg_init},

};

static const upb_MiniTableExtension *extensions_layout[1] = {
  &udpa_annotations_versioning_ext,
};

const upb_MiniTableFile udpa_annotations_versioning_proto_upb_file_layout = {
  messages_layout,
  NULL,
  extensions_layout,
  1,
  0,
  1,
};

#include "upb/port/undef.inc"
