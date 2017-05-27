use Image::Sixel::Raw;
use NativeCall;
use nqp;

class X::Sixel is Exception { has int $.status; has Str $.message; }

sub errorcheck($value --> Nil) {
    if SIXEL_FAILED($value) {
        X::Sixel.new(:message(sixel_helper_format_error($value)), :status($value)).throw
    }
}

sub create_default_output($out_handle = $*OUT) {
    return Sixel::Output.new(-> CArray[uint8] $data, int32 $length --> int32 {
        $*OUT.write(Buf[uint8].new($data[^$length]));

        return SIXEL_OK;
    })
}

class Sixel::Output {
    has sixel_output $.output;

    method new(&callback) {
        my sixel_output $output .= new;
        errorcheck(sixel_output_new($output, &callback, Pointer, sixel_allocator));
        sixel_output_ref($output);
        self.bless(:$output);
    }

    submethod DESTROY {
        sixel_output_unref($!output);
    }
}

class Sixel::Encoder {
    has sixel_encoder $!encoder;

    method new(:$output = create_default_output) {
        my sixel_encoder $encoder .= new;
        errorcheck(sixel_encoder_new($encoder, sixel_allocator));
        with $output {
            errorcheck(sixel_setopt($encoder, OF_OUTPUT
        }
        self.bless(encoder => $encoder);
    }

    submethod BUILD(:$!encoder) { }

    submethod DESTROY {
        sixel_encoder_unref($!encoder);
    }

    multi method setopt(optionFlag $option, Str $value) {
        self.setopt(ord($option), $value);
    }
    multi method setopt(int $option, Str $value) {
        errorcheck(sixel_encoder_setopt($!encoder, $option, $value));
    }

    multi method encode(Str $sourcefile) {
        errorcheck(sixel_encoder_encode($!encoder, $sourcefile));
    }

    multi method encode(CArray[uint8] $bytes, int32 $width, int32 $height,
                        pixelFormat $pfmt,
                        CArray[uint8] $palette, int32 $pcolors) {
        errorcheck(sixel_encoder_encode_bytes(
            $!encoder,
            $bytes, $width, $height,
            $pfmt,
            $palette, $pcolors));
    }
}
