  $(document).ready(function(){


          $("#service_photo").on('change', function () {

            if (typeof(FileReader) != "undefined") {

                var image_holder = $(".upload_image_box");
                image_holder.empty();

                var reader = new FileReader();
                reader.onload = function (e) {
                    $("<img />", {
                        "src": e.target.result,
                        "class": "thumb-image resolve",
                        "style": "width:120px; height:120px;"
                    }).appendTo(image_holder);
                }
                image_holder.show();
                reader.readAsDataURL($(this)[0].files[0]);
            } else {
                alert("This browser does not support FileReader.");
            }
        });
          })