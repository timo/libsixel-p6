use NativeCall;

## Enumerations

constant LIB = "/home/timo/prefix/lib/libsixel.so";

constant SIXELSTATUS = long;

constant LIBSIXEL_VERSION     = "1.7.3";
constant LIBSIXEL_ABI_VERSION = "1:6:0";

constant SIXEL_OUTPUT_PACKET_SIZE     = 16384;
constant SIXEL_PALETTE_MIN            = 2;
constant SIXEL_PALETTE_MAX            = 256;
constant SIXEL_USE_DEPRECATED_SYMBOLS = 1;

constant SIXEL_OK                = 0x0000;                          # succeeded
constant SIXEL_FALSE             = 0x1000;                          # failed

constant SIXEL_RUNTIME_ERROR     = (SIXEL_FALSE         +| 0x0100);  # runtime error
constant SIXEL_LOGIC_ERROR       = (SIXEL_FALSE         +| 0x0200);  # logic error
constant SIXEL_FEATURE_ERROR     = (SIXEL_FALSE         +| 0x0300);  # feature not enabled
constant SIXEL_LIBC_ERROR        = (SIXEL_FALSE         +| 0x0400);  # errors caused by curl
constant SIXEL_CURL_ERROR        = (SIXEL_FALSE         +| 0x0500);  # errors occures in libc functions
constant SIXEL_JPEG_ERROR        = (SIXEL_FALSE         +| 0x0600);  # errors occures in libjpeg functions
constant SIXEL_PNG_ERROR         = (SIXEL_FALSE         +| 0x0700);  # errors occures in libpng functions
constant SIXEL_GDK_ERROR         = (SIXEL_FALSE         +| 0x0800);  # errors occures in gdk functions
constant SIXEL_GD_ERROR          = (SIXEL_FALSE         +| 0x0900);  # errors occures in gd functions
constant SIXEL_STBI_ERROR        = (SIXEL_FALSE         +| 0x0a00);  # errors occures in stb_image functions
constant SIXEL_STBIW_ERROR       = (SIXEL_FALSE         +| 0x0b00);  # errors occures in stb_image_write functions

constant SIXEL_INTERRUPTED       = (SIXEL_OK            +| 0x0001);  # interrupted by a signal

constant SIXEL_BAD_ALLOCATION    = (SIXEL_RUNTIME_ERROR +| 0x0001);  # malloc() failed
constant SIXEL_BAD_ARGUMENT      = (SIXEL_RUNTIME_ERROR +| 0x0002);  # bad argument detected
constant SIXEL_BAD_INPUT         = (SIXEL_RUNTIME_ERROR +| 0x0003);  # bad input detected

constant SIXEL_NOT_IMPLEMENTED   = (SIXEL_FEATURE_ERROR +| 0x0001);  # feature not implemented

sub SIXEL_SUCCEEDED($status) is export { (($status) +& 0x1000) == 0 }
sub SIXEL_FAILED($status)    is export { (($status) +& 0x1000) != 0 }

enum optionFlag is export (
    OF_INPUT  => 'i',
    OF_OUTPUT => 'o',
    OF_7BIT_MODE => '7',
    OF_8BIT_MODE => '8',
    OF_HAS_GRI_ARG_LIMIT => 'R',
    OF_COLORS       => 'p',
    OF_MAPFILE      => 'm',
    OF_MONOCHROME   => 'e',
    OF_INSECURE     => 'k',
    OF_INVERT       => 'i',
    OF_HIGH_COLOR   => 'I',
    OF_USE_MACRO    => 'u',
    OF_MACRO_NUMBER => 'n',
    OF_COMPLEXION_SCORE => 'C',
    OF_DIFFUSION => 'd',
    OF_FIND_LARGEST => 'f',
    OF_SELECT_COLOR => 's',
    OF_CROP => 'c',
    OF_WIDTH => 'w',
    OF_HEIGHT => 'h',
    OF_RESAMPLING => 'r',
    OF_QUALITY => 'q',
    OF_LOOPMODE => 'l',
    OF_PALETTE_TYPE => 't',
    OF_BUILTIN_PALETTE => 'b',
    OF_ENCODE_POLICY => 'E',
    OF_BGCOLOR => 'B',
    OF_PENETRATE => 'P',
    OF_PIPE_MODE => 'D',
    OF_VERBOSE => 'v',
    OF_VERSION => 'v',
    OF_HELP => 'H',
);

# == /home/timo/perl6/ecosystem/libsixel/include/sixel.h ==

enum characterSize is export (
   CSIZE_7BIT => 0,
   CSIZE_8BIT => 1
);
enum methodForLargest is export (
   LARGE_AUTO => 0,
   LARGE_NORM => 1,
   LARGE_LUM => 2
);
enum methodForRep is export (
   REP_AUTO => 0,
   REP_CENTER_BOX => 1,
   REP_AVERAGE_COLORS => 2,
   REP_AVERAGE_PIXELS => 3
);
enum methodForDiffuse is export (
   DIFFUSE_AUTO => 0,
   DIFFUSE_NONE => 1,
   DIFFUSE_ATKINSON => 2,
   DIFFUSE_FS => 3,
   DIFFUSE_JAJUNI => 4,
   DIFFUSE_STUCKI => 5,
   DIFFUSE_BURKES => 6
);
enum qualityMode is export (
   QUALITY_AUTO => 0,
   QUALITY_HIGH => 1,
   QUALITY_LOW => 2,
   QUALITY_FULL => 3,
   QUALITY_HIGHCOLOR => 4
);
enum builtinDither is export (
   BUILTIN_MONO_DARK => 0,
   BUILTIN_MONO_LIGHT => 1,
   BUILTIN_XTERM16 => 2,
   BUILTIN_XTERM256 => 3,
   BUILTIN_VT340_MONO => 4,
   BUILTIN_VT340_COLOR => 5
);
enum formatType is export (
   FORMATTYPE_COLOR => 0,
   FORMATTYPE_GRAYSCALE => 64,
   FORMATTYPE_PALETTE => 128
);
enum pixelFormat is export (
   PIXELFORMAT_RGB555 => 1,
   PIXELFORMAT_RGB565 => 2,
   PIXELFORMAT_RGB888 => 3,
   PIXELFORMAT_BGR555 => 4,
   PIXELFORMAT_BGR565 => 5,
   PIXELFORMAT_BGR888 => 6,
   PIXELFORMAT_ARGB8888 => 16,
   PIXELFORMAT_RGBA8888 => 17,
   PIXELFORMAT_G1 => 64,
   PIXELFORMAT_G2 => 65,
   PIXELFORMAT_G4 => 66,
   PIXELFORMAT_G8 => 67,
   PIXELFORMAT_AG88 => 83,
   PIXELFORMAT_GA88 => 99,
   PIXELFORMAT_PAL1 => 128,
   PIXELFORMAT_PAL2 => 129,
   PIXELFORMAT_PAL4 => 130,
   PIXELFORMAT_PAL8 => 131
);
enum paletteType is export (
   PALETTETYPE_AUTO => 0,
   PALETTETYPE_HLS => 1,
   PALETTETYPE_RGB => 2
);
enum encodePolicy is export (
   ENCODEPOLICY_AUTO => 0,
   ENCODEPOLICY_FAST => 1,
   ENCODEPOLICY_SIZE => 2
);
enum methodForResampling is export (
   RES_NEAREST => 0,
   RES_GAUSSIAN => 1,
   RES_HANNING => 2,
   RES_HAMMING => 3,
   RES_BILINEAR => 4,
   RES_WELSH => 5,
   RES_BICUBIC => 6,
   RES_LANCZOS2 => 7,
   RES_LANCZOS3 => 8,
   RES_LANCZOS4 => 9
);
enum imageFormat is export (
   FORMAT_GIF => 0,
   FORMAT_PNG => 1,
   FORMAT_BMP => 2,
   FORMAT_JPG => 3,
   FORMAT_TGA => 4,
   FORMAT_WBMP => 5,
   FORMAT_TIFF => 6,
   FORMAT_SIXEL => 7,
   FORMAT_PNM => 8,
   FORMAT_GD2 => 9,
   FORMAT_PSD => 10,
   FORMAT_HDR => 11
);
enum loopControl is export (
   LOOP_AUTO => 0,
   LOOP_FORCE => 1,
   LOOP_DISABLE => 2
);
## Structures

# == /home/timo/perl6/ecosystem/libsixel/include/sixel.h ==

class sixel_allocator is repr('CPointer') is export {
}
class sixel_output is repr('CPointer') is export {
}
class sixel_dither is repr('CPointer') is export {
}
class sixel_frame is repr('CPointer') is export {
}
class sixel_encoder is repr('CPointer') is export {
}
class sixel_decoder is repr('CPointer') is export {
}

## Functions


# == /home/timo/perl6/ecosystem/libsixel/include/sixel.h ==

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:492
#/* create allocator object */
#SIXELSTATUS
#sixel_allocator_new(
sub sixel_allocator_new(sixel_allocator      $ppallocator is rw # Typedef<sixel_allocator_t>->|sixel_allocator|**
                       ,&fn_malloc ( size_t           --> Pointer) # Typedef<sixel_malloc_t>->|F:void* ( )*|
                       ,&fn_calloc ( size_t,   size_t --> Pointer) # Typedef<sixel_calloc_t>->|F:void* ( )*|
                       ,&fn_realloc ( Pointer, size_t --> Pointer) # Typedef<sixel_realloc_t>->|F:void* ( )*|
                       ,&fn_free ( Pointer ) # Typedef<sixel_free_t>->|F:void ( )*|
                        ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:501
#/* increase reference count of allocator object (thread-unsafe) */
#SIXELAPI void
#sixel_allocator_ref(
sub sixel_allocator_ref(sixel_allocator $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                        ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:507
#/* decrease reference count of output context object (thread-unsafe) */
#SIXELAPI void
#sixel_allocator_unref(sixel_allocator_t *allocator);
sub sixel_allocator_unref(sixel_allocator $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                          ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:511
#/* call custom malloc() */
#SIXELAPI void *
#sixel_allocator_malloc(
sub sixel_allocator_malloc(sixel_allocator               $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                          ,size_t                        $n # Typedef<size_t>->|long unsigned int|
                           ) is native(LIB) returns Pointer is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:517
#/* call custom calloc() */
#SIXELAPI void *
#sixel_allocator_calloc(
sub sixel_allocator_calloc(sixel_allocator               $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                          ,size_t                        $nelm # Typedef<size_t>->|long unsigned int|
                          ,size_t                        $elsize # Typedef<size_t>->|long unsigned int|
                           ) is native(LIB) returns Pointer is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:524
#/* call custom realloc() */
#SIXELAPI void *
#sixel_allocator_realloc(
sub sixel_allocator_realloc(sixel_allocator               $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                           ,Pointer                       $p # void*
                           ,size_t                        $n # Typedef<size_t>->|long unsigned int|
                            ) is native(LIB) returns Pointer is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:531
#/* call custom free() */
#SIXELAPI void
#sixel_allocator_free(
sub sixel_allocator_free(sixel_allocator               $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                        ,Pointer                       $p # void*
                         ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:564
#/* create new output context object */
#SIXELAPI SIXELSTATUS
#sixel_output_new(
sub sixel_output_new(sixel_output         $output # Typedef<sixel_output_t>->|sixel_output|**
                    ,&fn_write ( --> int32) # Typedef<sixel_write_function>->|F:int ( )*|
                    ,Pointer                       $priv # void*
                    ,sixel_allocator               $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                     ) is native(LIB) returns SIXELSTATUS is export { * }


#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:580
#                                               3rd argument of fn_write */
#/* destroy output context object */
#SIXELAPI void
#sixel_output_destroy(sixel_output_t /* in */ *output); /* output context */
sub sixel_output_destroy(sixel_output $output # Typedef<sixel_output_t>->|sixel_output|*
                         ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:584
#/* increase reference count of output context object (thread-unsafe) */
#SIXELAPI void
#sixel_output_ref(sixel_output_t /* in */ *output);     /* output context */
sub sixel_output_ref(sixel_output $output # Typedef<sixel_output_t>->|sixel_output|*
                     ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:588
#/* decrease reference count of output context object (thread-unsafe) */
#SIXELAPI void
#sixel_output_unref(sixel_output_t /* in */ *output);   /* output context */
sub sixel_output_unref(sixel_output $output # Typedef<sixel_output_t>->|sixel_output|*
                       ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:592
#/* get 8bit output mode which indicates whether it uses C1 control characters */
#SIXELAPI int
#sixel_output_get_8bit_availability(
sub sixel_output_get_8bit_availability(sixel_output $output # Typedef<sixel_output_t>->|sixel_output|*
                                       ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:597
#/* set 8bit output mode state */
#SIXELAPI void
#sixel_output_set_8bit_availability(
sub sixel_output_set_8bit_availability(sixel_output                  $output # Typedef<sixel_output_t>->|sixel_output|*
                                      ,int32                         $availability # int
                                       ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:604
#/* set whether limit arguments of DECGRI('!') to 255 */
#SIXELAPI void
#sixel_output_set_gri_arg_limit(
sub sixel_output_set_gri_arg_limit(sixel_output                  $output # Typedef<sixel_output_t>->|sixel_output|*
                                  ,int32                         $value # int
                                   ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:611
#/* set GNU Screen penetration feature enable or disable */
#SIXELAPI void
#sixel_output_set_penetrate_multiplexer(
sub sixel_output_set_penetrate_multiplexer(sixel_output                  $output # Typedef<sixel_output_t>->|sixel_output|*
                                          ,int32                         $penetrate # int
                                           ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:618
#/* set whether we skip DCS envelope */
#SIXELAPI void
#sixel_output_set_skip_dcs_envelope(
sub sixel_output_set_skip_dcs_envelope(sixel_output                  $output # Typedef<sixel_output_t>->|sixel_output|*
                                      ,int32                         $skip # int
                                       ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:625
#/* set palette type: RGB or HLS */
#SIXELAPI void
#sixel_output_set_palette_type(
sub sixel_output_set_palette_type(sixel_output                  $output # Typedef<sixel_output_t>->|sixel_output|*
                                 ,int32                         $palettetype # int
                                  ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:632
#/* set encodeing policy: auto, fast or size */
#SIXELAPI void
#sixel_output_set_encode_policy(
sub sixel_output_set_encode_policy(sixel_output                  $output # Typedef<sixel_output_t>->|sixel_output|*
                                  ,int32                         $encode_policy # int
                                   ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:654
#/* create dither context object */
#SIXELAPI SIXELSTATUS
#sixel_dither_new(
sub sixel_dither_new(sixel_dither         $ppdither # Typedef<sixel_dither_t>->|sixel_dither|**
                    ,int32                         $ncolors # int
                    ,sixel_allocator               $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                     ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:666
#/* get built-in dither context object */
#SIXELAPI sixel_dither_t *
#sixel_dither_get(int builtin_dither); /* ID of built-in dither object */
sub sixel_dither_get(int32 $builtin_dither # int
                     ) is native(LIB) returns sixel_dither is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:670
#/* destroy dither context object */
#SIXELAPI void
#sixel_dither_destroy(sixel_dither_t *dither); /* dither context object */
sub sixel_dither_destroy(sixel_dither $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                         ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:674
#/* increase reference count of dither context object (thread-unsafe) */
#SIXELAPI void
#sixel_dither_ref(sixel_dither_t *dither); /* dither context object */
sub sixel_dither_ref(sixel_dither $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                     ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:678
#/* decrease reference count of dither context object (thread-unsafe) */
#SIXELAPI void
#sixel_dither_unref(sixel_dither_t *dither); /* dither context object */
sub sixel_dither_unref(sixel_dither $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                       ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:682
#/* initialize internal palette from specified pixel buffer */
#SIXELAPI SIXELSTATUS
#sixel_dither_initialize(
sub sixel_dither_initialize(sixel_dither                  $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                           ,Pointer[uint8]                $data # unsigned char*
                           ,int32                         $width # int
                           ,int32                         $height # int
                           ,int32                         $pixelformat # int
                           ,int32                         $method_for_largest # int
                           ,int32                         $method_for_rep # int
                           ,int32                         $quality_mode # int
                            ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:694
#/* set diffusion type, choose from enum methodForDiffuse */
#SIXELAPI void
#sixel_dither_set_diffusion_type(
sub sixel_dither_set_diffusion_type(sixel_dither                  $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                                   ,int32                         $method_for_diffuse # int
                                    ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:700
#/* get number of palette colors */
#SIXELAPI int
#sixel_dither_get_num_of_palette_colors(
sub sixel_dither_get_num_of_palette_colors(sixel_dither $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                                           ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:705
#/* get number of histogram colors */
#SIXELAPI int
#sixel_dither_get_num_of_histogram_colors(
sub sixel_dither_get_num_of_histogram_colors(sixel_dither $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                                             ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:714
#/* get palette */
#SIXELAPI unsigned char *
#sixel_dither_get_palette(
sub sixel_dither_get_palette(sixel_dither $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                             ) is native(LIB) returns Pointer[uint8] is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:719
#/* set palette */
#SIXELAPI void
#sixel_dither_set_palette(
sub sixel_dither_set_palette(sixel_dither                  $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                            ,Pointer[uint8]                $palette # unsigned char*
                             ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:725
#/* set the factor of complexion color correcting */
#SIXELAPI void
#sixel_dither_set_complexion_score(
sub sixel_dither_set_complexion_score(sixel_dither                  $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                                     ,int32                         $score # int
                                      ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:731
#/* set whether omitting palette difinition */
#SIXELAPI void
#sixel_dither_set_body_only(
sub sixel_dither_set_body_only(sixel_dither                  $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                              ,int32                         $bodyonly # int
                               ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:737
#                                          1: do not output palette section */
#/* set whether optimize palette size */
#SIXELAPI void
#sixel_dither_set_optimize_palette(
sub sixel_dither_set_optimize_palette(sixel_dither                  $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                                     ,int32                         $do_opt # int
                                      ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:743
#                                          1: don't optimize palette size */
#/* set pixelformat */
#SIXELAPI void
#sixel_dither_set_pixelformat(
sub sixel_dither_set_pixelformat(sixel_dither                  $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                                ,int32                         $pixelformat # int
                                 ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:749
#/* set transparent */
#SIXELAPI void
#sixel_dither_set_transparent(
sub sixel_dither_set_transparent(sixel_dither                  $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                                ,int32                         $transparent # int
                                 ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:767
#/* convert pixels into sixel format and write it to output context */
#SIXELAPI SIXELSTATUS
#sixel_encode(
sub sixel_encode(Pointer[uint8]                $pixels # unsigned char*
                ,int32                         $width # int
                ,int32                         $height # int
                ,int32                         $depth # int
                ,sixel_dither                  $dither # Typedef<sixel_dither_t>->|sixel_dither|*
                ,sixel_output                  $context # Typedef<sixel_output_t>->|sixel_output|*
                 ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:777
#/* convert sixel data into indexed pixel bytes and palette data */
#SIXELAPI SIXELSTATUS
#sixel_decode_raw(
sub sixel_decode_raw(Pointer[uint8]                $p # unsigned char*
                    ,int32                         $len # int
                    ,Pointer[Pointer[uint8]]       $pixels # unsigned char**
                    ,Pointer[int32]                $pwidth # int*
                    ,Pointer[int32]                $pheight # int*
                    ,Pointer[Pointer[uint8]]       $palette # unsigned char**
                    ,Pointer[int32]                $ncolors # int*
                    ,sixel_allocator               $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                     ) is native(LIB) returns SIXELSTATUS is export { * }


#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:809
#SIXELAPI void
#sixel_helper_set_additional_message(
sub sixel_helper_set_additional_message(Str $message # const char*
                                        ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:814
#SIXELAPI char const *
#sixel_helper_get_additional_message(void);
sub sixel_helper_get_additional_message(
                                        ) is native(LIB) returns Str is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:818
#/* convert error status code int formatted string */
#SIXELAPI char const *
#sixel_helper_format_error(
sub sixel_helper_format_error(SIXELSTATUS $status # Typedef<SIXELSTATUS>->|int|
                              ) is native(LIB) returns Str is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:824
#/* compute pixel depth from pixelformat */
#SIXELAPI int
#sixel_helper_compute_depth(
sub sixel_helper_compute_depth(int32 $pixelformat # int
                               ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:830
#/* convert pixelFormat into PIXELFORMAT_RGB888 */
#SIXELAPI SIXELSTATUS
#sixel_helper_normalize_pixelformat(
sub sixel_helper_normalize_pixelformat(Pointer[uint8]                $dst # unsigned char*
                                      ,Pointer[int32]                $dst_pixelformat # int*
                                      ,Pointer[uint8]                $src # const unsigned char*
                                      ,int32                         $src_pixelformat # int
                                      ,int32                         $width # int
                                      ,int32                         $height # int
                                       ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:841
#/* scale image to specified size */
#SIXELAPI SIXELSTATUS
#sixel_helper_scale_image(
sub sixel_helper_scale_image(Pointer[uint8]                $dst # unsigned char*
                            ,Pointer[uint8]                $src # const unsigned char*
                            ,int32                         $srcw # int
                            ,int32                         $srch # int
                            ,int32                         $pixelformat # int
                            ,int32                         $dstw # int
                            ,int32                         $dsth # int
                            ,int32                         $method_for_resampling # int
                            ,sixel_allocator               $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                             ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:894
#/* constructor of frame object */
#SIXELAPI SIXELSTATUS
#sixel_frame_new(
sub sixel_frame_new(sixel_frame          $ppframe # Typedef<sixel_frame_t>->|sixel_frame|**
                   ,sixel_allocator               $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                    ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:900
#                                                   default allocator */

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:904
#/* increase reference count of frame object (thread-unsafe) */
#SIXELAPI void
#sixel_frame_ref(sixel_frame_t /* in */ *frame);
sub sixel_frame_ref(sixel_frame $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                    ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:908
#/* decrease reference count of frame object (thread-unsafe) */
#SIXELAPI void
#sixel_frame_unref(sixel_frame_t /* in */ *frame);
sub sixel_frame_unref(sixel_frame $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                      ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:912
#/* initialize frame object with a pixel buffer */
#SIXELAPI SIXELSTATUS
#sixel_frame_init(
sub sixel_frame_init(sixel_frame                   $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                    ,Pointer[uint8]                $pixels # unsigned char*
                    ,int32                         $width # int
                    ,int32                         $height # int
                    ,int32                         $pixelformat # int
                    ,Pointer[uint8]                $palette # unsigned char*
                    ,int32                         $ncolors # int
                     ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:924
#/* get pixels */
#SIXELAPI unsigned char *
#sixel_frame_get_pixels(sixel_frame_t /* in */ *frame);  /* frame object */
sub sixel_frame_get_pixels(sixel_frame $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                           ) is native(LIB) returns Pointer[uint8] is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:928
#/* get palette */
#SIXELAPI unsigned char *
#sixel_frame_get_palette(sixel_frame_t /* in */ *frame);  /* frame object */
sub sixel_frame_get_palette(sixel_frame $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                            ) is native(LIB) returns Pointer[uint8] is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:932
#/* get width */
#SIXELAPI int
#sixel_frame_get_width(sixel_frame_t /* in */ *frame);  /* frame object */
sub sixel_frame_get_width(sixel_frame $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                          ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:936
#/* get height */
#SIXELAPI int
#sixel_frame_get_height(sixel_frame_t /* in */ *frame);  /* frame object */
sub sixel_frame_get_height(sixel_frame $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                           ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:940
#/* get ncolors */
#SIXELAPI int
#sixel_frame_get_ncolors(sixel_frame_t /* in */ *frame);  /* frame object */
sub sixel_frame_get_ncolors(sixel_frame $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                            ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:944
#/* get pixelformat */
#SIXELAPI int
#sixel_frame_get_pixelformat(sixel_frame_t /* in */ *frame);  /* frame object */
sub sixel_frame_get_pixelformat(sixel_frame $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                                ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:948
#/* get transparent */
#SIXELAPI int
#sixel_frame_get_transparent(sixel_frame_t /* in */ *frame);  /* frame object */
sub sixel_frame_get_transparent(sixel_frame $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                                ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:952
#/* get transparent */
#SIXELAPI int
#sixel_frame_get_multiframe(sixel_frame_t /* in */ *frame);  /* frame object */
sub sixel_frame_get_multiframe(sixel_frame $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                               ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:956
#/* get delay */
#SIXELAPI int
#sixel_frame_get_delay(sixel_frame_t /* in */ *frame);  /* frame object */
sub sixel_frame_get_delay(sixel_frame $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                          ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:960
#/* get frame no */
#SIXELAPI int
#sixel_frame_get_frame_no(sixel_frame_t /* in */ *frame);  /* frame object */
sub sixel_frame_get_frame_no(sixel_frame $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                             ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:964
#/* get loop no */
#SIXELAPI int
#sixel_frame_get_loop_no(sixel_frame_t /* in */ *frame);  /* frame object */
sub sixel_frame_get_loop_no(sixel_frame $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                            ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:968
#/* strip alpha from RGBA/ARGB formatted pixbuf */
#SIXELAPI int
#sixel_frame_strip_alpha(
sub sixel_frame_strip_alpha(sixel_frame                   $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                           ,Pointer[uint8]                $bgcolor # unsigned char*
                            ) is native(LIB) returns int32 is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:974
#/* resize a frame to given size with specified resampling filter */
#SIXELAPI SIXELSTATUS
#sixel_frame_resize(
sub sixel_frame_resize(sixel_frame                   $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                      ,int32                         $width # int
                      ,int32                         $height # int
                      ,int32                         $method_for_resampling # int
                       ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:982
#/* clip frame */
#SIXELAPI SIXELSTATUS
#sixel_frame_clip(
sub sixel_frame_clip(sixel_frame                   $frame # Typedef<sixel_frame_t>->|sixel_frame|*
                    ,int32                         $x # int
                    ,int32                         $y # int
                    ,int32                         $width # int
                    ,int32                         $height # int
                     ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:994
#SIXELAPI SIXELSTATUS
#sixel_helper_load_image_file(
sub sixel_helper_load_image_file(Str                           $filename # const char*
                                ,int32                         $fstatic # int
                                ,int32                         $fuse_palette # int
                                ,int32                         $reqcolors # int
                                ,Pointer[uint8]                $bgcolor # unsigned char*
                                ,int32                         $loop_control # int
                                ,&fn_load ( --> SIXELSTATUS) # Typedef<sixel_load_image_function>->|F:Typedef<SIXELSTATUS>->|int| ( )*|
                                ,int32                         $finsecure # int
                                ,Pointer[int32]                $cancel_flag # const int*
                                ,Pointer                       $context # void*
                                ,sixel_allocator               $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                                 ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:1009
#/* write image to file */
#SIXELAPI SIXELSTATUS
#sixel_helper_write_image_file(
sub sixel_helper_write_image_file(Pointer[uint8]                $data # unsigned char*
                                 ,int32                         $width # int
                                 ,int32                         $height # int
                                 ,Pointer[uint8]                $palette # unsigned char*
                                 ,int32                         $pixelformat # int
                                 ,Str                           $filename # const char*
                                 ,int32                         $imageformat # int
                                 ,sixel_allocator               $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                                  ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:1036
#/* create encoder object */
#SIXELAPI SIXELSTATUS
#sixel_encoder_new(
sub sixel_encoder_new(sixel_encoder        $ppencoder # Typedef<sixel_encoder_t>->|sixel_encoder|**
                     ,sixel_allocator               $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                      ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:1047
#/* increase reference count of encoder object (thread-unsafe) */
#SIXELAPI void
#sixel_encoder_ref(sixel_encoder_t /* in */ *encoder);
sub sixel_encoder_ref(sixel_encoder $encoder # Typedef<sixel_encoder_t>->|sixel_encoder|*
                      ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:1051
#/* decrease reference count of encoder object (thread-unsafe) */
#SIXELAPI void
#sixel_encoder_unref(sixel_encoder_t /* in */ *encoder);
sub sixel_encoder_unref(sixel_encoder $encoder # Typedef<sixel_encoder_t>->|sixel_encoder|*
                        ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:1055
#/* set cancel state flag to encoder object */
#SIXELAPI SIXELSTATUS
#sixel_encoder_set_cancel_flag(
sub sixel_encoder_set_cancel_flag(sixel_encoder                 $encoder # Typedef<sixel_encoder_t>->|sixel_encoder|*
                                 ,Pointer[int32]                $cancel_flag # int*
                                  ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:1061
#/* set an option flag to encoder object */
#SIXELAPI SIXELSTATUS
#sixel_encoder_setopt(
sub sixel_encoder_setopt(sixel_encoder                 $encoder # Typedef<sixel_encoder_t>->|sixel_encoder|*
                        ,int32                         $arg # int
                        ,Str                           $optarg # const char*
                         ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:1068
#/* load source data from specified file and encode it to SIXEL format */
#SIXELAPI SIXELSTATUS
#sixel_encoder_encode(
sub sixel_encoder_encode(sixel_encoder                 $encoder # Typedef<sixel_encoder_t>->|sixel_encoder|*
                        ,Str                           $filename # const char*
                         ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:1075
#/* encode specified pixel data to SIXEL format
# * output to encoder->outfd */
#SIXELAPI SIXELSTATUS
#sixel_encoder_encode_bytes(
sub sixel_encoder_encode_bytes(sixel_encoder                 $encoder # Typedef<sixel_encoder_t>->|sixel_encoder|*
                              ,Pointer[uint8]                $bytes # unsigned char*
                              ,int32                         $width # int
                              ,int32                         $height # int
                              ,int32                         $pixelformat # int
                              ,Pointer[uint8]                $palette # unsigned char*
                              ,int32                         $ncolors # int
                               ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:1101
#/* create decoder object */
#SIXELAPI SIXELSTATUS
#sixel_decoder_new(
sub sixel_decoder_new(sixel_decoder        $ppdecoder # Typedef<sixel_decoder_t>->|sixel_decoder|**
                     ,sixel_allocator               $allocator # Typedef<sixel_allocator_t>->|sixel_allocator|*
                      ) is native(LIB) returns SIXELSTATUS is export { * }


#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:1112
#/* increase reference count of decoder object (thread-unsafe) */
#SIXELAPI void
#sixel_decoder_ref(sixel_decoder_t *decoder);
sub sixel_decoder_ref(sixel_decoder $decoder # Typedef<sixel_decoder_t>->|sixel_decoder|*
                      ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:1116
#/* decrease reference count of decoder object (thread-unsafe) */
#SIXELAPI void
#sixel_decoder_unref(sixel_decoder_t *decoder);
sub sixel_decoder_unref(sixel_decoder $decoder # Typedef<sixel_decoder_t>->|sixel_decoder|*
                        ) is native(LIB)  is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:1120
#/* set an option flag to decoder object */
#SIXELAPI SIXELSTATUS
#sixel_decoder_setopt(
sub sixel_decoder_setopt(sixel_decoder                 $decoder # Typedef<sixel_decoder_t>->|sixel_decoder|*
                        ,int32                         $arg # int
                        ,Str                           $optarg # const char*
                         ) is native(LIB) returns SIXELSTATUS is export { * }

#-From /home/timo/perl6/ecosystem/libsixel/include/sixel.h:1128
#/* load source data from stdin or the file specified with
#   SIXEL_OPTFLAG_INPUT flag, and decode it */
#SIXELAPI SIXELSTATUS
#sixel_decoder_decode(
sub sixel_decoder_decode(sixel_decoder $decoder # Typedef<sixel_decoder_t>->|sixel_decoder|*
                         ) is native(LIB) returns SIXELSTATUS is export { * }

## Externs

