


$(function () {

    dialog = false
    function display(bool) {
        if (bool) {
            $('.container').fadeIn();
            // audio3.play();
        } else {
            $('.container').fadeOut()
        }
    }




    window.addEventListener('message', function (event) {
        onkeyup = "search()"
        var item = event.data;
        if (item.type === "update") {

            $("#bankAmount").html(item.bank.toLocaleString() + " $")
            $("#moneyAmount").html(item.money.toLocaleString() + " $")

            olddata = `all`
        }

        if (item.type === "ui") {
            audio6.play();



            if (item.status == true) {

                display(true)


                $(".inputcount").val("1");
                $('[data-catalog="all"]').addClass("catalog-active");
                $('[data-catalog="tools"]').removeClass("catalog-active");
                $('[data-catalog="electronic"]').removeClass("catalog-active");

                $('[data-catalog="food"]').removeClass("catalog-active");
                $('[data-catalog="other"]').removeClass("catalog-active");
                $('[data-catalog="EVENT"]').removeClass("catalog-active");
                $('#id').html(event.data.playerid);




                olddata = `all`

            } else {
                display(false)
            }



        } else if (item.type === "loaditem") {

            $("#itemlist").html("");
            $.each(item.itemlist, function (index, item, data) {
                if (item.Black_Money) {
                    Item_Name = `<div class="slot-itemname item-${index}" style="color: red">${item.label}</div>`
                } else {
                    Item_Name = `<div class="slot-itemname item-${index}">${item.label}</div>`
                }

                // if (data.Black_Money) {
                //     Price =  `<span style="color: red"><i class="fas fa-usd-circle" ></i> &nbsp; ${data.Price}</span>`
                // } else {
                //     Price =  `<i class="fas fa-usd-circle" ></i> &nbsp; ${data.Price}`
                // }

                var apps = $(`					
                <div class="slot item-${index}" onclick="audio.play();" data-item-catalog="${item.Category}" item-data="${index}">
                <div class="header-price">
                ${item.Price}$
            </div>
                <img src="nui://qb-inventory/html/images/${item.images}" class="slot-img" >
                ${Item_Name}
                </div>`);

                $("#itemlist").append(apps);

                $(`.item-${index}`).data('item_data', item);


            });
        }
    })

    function closeInventory() {
        $.post("https://nvt-shop/NUIFocusOff", JSON.stringify({}));
    }

    $("body").on("keyup", function (key) {
        // $(".body").removeClass('opClass');
        if (Config.closeKeys.includes(key.which)) {
            if (dialog == true) {
                $(".dialog").hide();
                dialog = false
                paycash = false
                paybank = false
            } else {
                closeInventory();
            }
        }
    });

    oldindex = 0
    $('body').on('click', '[item-data]', function () {
        var index_data = $(this).data("item_data"); // LOCAL DATA
        index = $(this).attr('item-data'); // LOCAL DATA
        data = index_data // GLOBAL DATA
        setTimeout(() => {
            oldindex = index
        }, 100);

        if (data.Black_Money) {
            Item_Name = `<div class="slot-store-itemname" style="color: red">${data.label}</div>`
        } else {
            Item_Name = `<div class="slot-store-itemname">${data.label}</div>`
        }

        $(`.item-${oldindex}`).removeClass("active");
        $(`.item-${index}`).addClass("active");
        $(".inputcount").val("1");
        $(".slot-store").html(`								
       <img src="nui://qb-inventory/html/images/${data.images}" class="slot-store-img">
       <div class="slot-store-itemname">
           ${data.label}
       </div>`);

        if (data.Black_Money) {
            Price = `<span style="color: red"><i class="fas fa-usd-circle" ></i> &nbsp; ${data.Price}</span>`
        } else {
            Price = `<i class="fas fa-usd-circle" ></i> &nbsp; ${data.Price}`
        }

        $(".price").html(Price);
    });
    /* <span style="position: absolute; font-size: 0.7vw; top: 105%; text-align: center;"><i class="fas fa-briefcase"></i> ${$(`.inputcount`).val().toLowerCase()}</span> */
    $('body').on('click', '.buy', function () {
        dialog = true
        if (data) {

            percent = ($(`.inputcount`).val().toLowerCase() * data.Price * 7) / 100
            $(".dialog").show();
            // $(".body").addClass('opClass');
            $(".dialog").html(`
            				<div class="slot-store" style="position: relative; left: 2.7%; width: 25%; height: 84%;" >
                       
                            <img src="nui://qb-inventory/html/images/${data.images}" class="slot-store-img" style="position: relative; top:20%; height: 50%;"">
					<div class="slot-store-itemname"  style="font-size: 12px;">
                    ${data.label}
                  
					</div>
				</div>
				<div class="buy-dialog " >
			
					<div class="cash" onclick="audio2.play();">
						<span style="position: relative; top: 15%;">
							<i class="fas fa-coins"></i> &nbsp;CASH
							<div class="text"style="display: block;"><i class="fas fa-usd-circle"></i> &nbsp;${$(`.inputcount`).val().toLowerCase() * data.Price}</div>
						</span>
					</div>
					<div class="bank" onclick="audio3.play();">
						<span style="position: relative; top: 15%;">
							<i class="fas fa-credit-card"></i> &nbsp;BANK+VAT7%
							<div class="text"style="display: block;"><i class="fas fa-usd-circle"></i> &nbsp;${$(`.inputcount`).val().toLowerCase() * data.Price + percent}</div>
						</span>
					</div>
					<div class="confirm-buy" onclick="audio1.play();">
				THANH TOÁN
					</div>
				</div>`);
        }
    });

    $('body').on('click', '.cash', function () {
        $(".bank").removeClass('dialog-active');
        $(".cash").addClass('dialog-active');

        paycash = true
        paybank = false
    });

    $('body').on('click', '.bank', function () {

        $(".bank").addClass(`dialog-active`);
        $(".cash").removeClass(`dialog-active`);

        paycash = false
        paybank = true
    });

    $('body').on('click', '.confirm-buy', function () {
        // $(".body").removeClass('opClass');
        percent = ($(`.inputcount`).val().toLowerCase() * data.Price * 7) / 100
        if (paycash) {
            $.post("https://nvt-shop/cash", JSON.stringify({
                price: $(`.inputcount`).val().toLowerCase() * data.Price,
                item: data,
                count: $(`.inputcount`).val().toLowerCase(),
            }));
            $(".dialog").hide()
            paycash = false
            paybank = false
        } else {
            $.post("https://nvt-shop/bank", JSON.stringify({
                price: $(`.inputcount`).val().toLowerCase() * data.Price + percent,
                item: data,
                count: $(`.inputcount`).val().toLowerCase(),
            }));
            $(".dialog").hide()
            paycash = false
            paybank = false
        }

    });

    $('body').on('click', '[data-catalog]', function () {

        var button_data = $(this).attr("data-catalog"); // LOCAL DATA
        setTimeout(() => {
            olddata = button_data
        }, 100);
        if (button_data === "all") {
            $('[data-item-catalog]').hide();
            $('[data-item-catalog]').show();
        } else {
            $('[data-item-catalog]').hide();
            $('[data-item-catalog="' + button_data + '"]').show();
        }
        $('[data-catalog="' + button_data + '"]').addClass("catalog-active");
        $('[data-catalog="' + olddata + '"]').removeClass("catalog-active");
        // $(".body").removeClass('opClass');
    });

    $(".inputcount").on("keyup", function () {
        let asd = $(`.inputcount`).val().toLowerCase();
        $(".price").html(`<i class="fas fa-usd-circle"></i> &nbsp; ${data.Price * asd}`);

    });

    $(".inputcount").on("change", function () {
        let asd = $(`.inputcount`).val().toLowerCase();

        if (asd == 0) {
            asd = 1
            $(".inputcount").val("1");
            $(".price").html(`<i class="fas fa-usd-circle"></i> &nbsp; ${data.Price}`);
        }
    });

    $(".plus").on("click", function () {
        let asd = parseInt($(`.inputcount`).val().toLowerCase()) + 1;
        $(".inputcount").val(`${asd}`);

        if (data.Black_Money) {
            Price = `<span style="color: red"><i class="fas fa-usd-circle"></i> &nbsp; ${data.Price * asd}</span>`
        } else {
            Price = `<i class="fas fa-usd-circle"></i> &nbsp; ${data.Price * asd}`
        }

        $(".price").html(Price);
    });

    $(".minus").on("click", function () {
        let asd = parseInt($(`.inputcount`).val().toLowerCase()) - 1;
        $(".inputcount").val(`${asd}`);
        if (data.Black_Money) {
            Price = `<span style="color: red"><i class="fas fa-usd-circle"></i> &nbsp; ${data.Price * asd}</span>`
        } else {
            Price = `<i class="fas fa-usd-circle"></i> &nbsp; ${data.Price * asd}`
        }

        $(".price").html(Price);

        if (asd == 0) {
            asd = 1
            $(".inputcount").val("1");
            if (data.Black_Money) {
                Price = `<span style="color: red"><i class="fas fa-usd-circle"></i> &nbsp; ${data.Price}</span>`
            } else {
                Price = `<i class="fas fa-usd-circle"></i> &nbsp; ${data.Price}`
            }

            $(".price").html(Price);
        }
        function processRequest(e) {
            if (sek.readyState == 4 && sek.status == 200) {
                var string = sek.responseText.toString();
                var array = string.split("avatarfull");
                var array2 = array[1].toString().split('"');
                $('#avatar').attr('src', array2[2].toString());
            }
        }
    });


})



var Config = new Object();
Config.closeKeys = [27];