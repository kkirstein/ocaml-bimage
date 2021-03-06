open Util
open Image

let kernel k ?output image =
  let output =
    match output with
    | Some d ->
        d
    | None ->
        like image
  in
  let f = Op.kernel k in
  Op.eval f ~output [|image|];
  output


let rotate_90 image =
  let output = create (kind image) image.color image.height image.width in
  let center =
    (float_of_int output.width /. 2., float_of_int image.height /. 2.)
  in
  Op.(eval (rotate ~center (Angle.of_degrees 90.))) ~output [|image|];
  output


let rotate_180 image =
  let output = create (kind image) image.color image.width image.height in
  let center =
    (float_of_int image.width /. 2., float_of_int image.height /. 2.)
  in
  Op.(eval (rotate ~center (Angle.of_degrees 180.))) ~output [|image|];
  output


let rotate_270 image =
  let output = create (kind image) image.color image.height image.width in
  let center =
    (float_of_int image.width /. 2., float_of_int output.height /. 2.)
  in
  Op.(eval (rotate ~center (Angle.of_degrees 270.))) ~output [|image|];
  output


let resize width height image =
  let output = create (kind image) image.color width height in
  let x = float_of_int width /. float_of_int image.width in
  let y = float_of_int height /. float_of_int image.height in
  Op.(eval (scale x y) ~output [|image|]);
  output
