

  // MONEY HUD
  const { ref, onBeforeUnmount } = Vue

  const moneyHud = Vue.createApp({
    data() {
      return {
        cash: 0,
        bank: 0,
        crypto: 0,
        amount: 0,
        plus: false,
        minus: false,
        showCash: false,
        showBank: false,
        showCrypto: false,
        showUpdate: false,
      };
    },
    destroyed() {
      window.removeEventListener("message", this.listener);
    },
    mounted() {
      this.listener = window.addEventListener("message", (event) => {
        switch (event.data.action) {
          case "showconstant":
            this.showConstant(event.data);
            break;
          case "updatemoney":
            this.update(event.data);
            break;
          case "show":
            this.showAccounts(event.data);
            break;
        }
      });
    },
    methods: {
      // CONFIGURE YOUR CURRENCY HERE
      // https://www.w3schools.com/tags/ref_language_codes.asp LANGUAGE CODES
      // https://www.w3schools.com/tags/ref_country_codes.asp COUNTRY CODES
      formatMoney(value) {
        const formatter = new Intl.NumberFormat("en-US", {
          style: "currency",
          currency: "USD",
          minimumFractionDigits: 0,
        });
        return formatter.format(value);
      },
      showConstant(data) {
        this.showCash = true;
        this.showBank = true;
        this.cash = data.cash;
        this.bank = data.bank;
        this.showCrypto = true;
        this.crypto = data.crypto;
      },
      update(data) {
        this.showUpdate = true;
        this.amount = data.amount;
        this.bank = data.bank;
        this.cash = data.cash;
        this.crypto = data.crypto;
        this.minus = data.minus;
        this.plus = data.plus;
        if (data.type === "cash") {
          if (data.minus) {
            this.showCash = true;
            this.minus = true;
            setTimeout(() => (this.showUpdate = false), 1000);
            setTimeout(() => (this.showCash = false), 2000);
          } else {
            this.showCash = true;
            this.plus = true;
            setTimeout(() => (this.showUpdate = false), 1000);
            setTimeout(() => (this.showCash = false), 2000);
          }
        }
        if (data.type === "bank") {
          if (data.minus) {
            this.showBank = true;
            this.minus = true;
            setTimeout(() => (this.showUpdate = false), 1000);
            setTimeout(() => (this.showBank = false), 2000);
          } else {
            this.showBank = true;
            this.plus = true;
            setTimeout(() => (this.showUpdate = false), 1000);
            setTimeout(() => (this.showBank = false), 2000);
          }
        }
        if (data.type === "crypto") {
          if (data.minus) {
            this.showCrypto = true;
            this.minus = true;
            setTimeout(() => (this.showUpdate = false), 1000);
            setTimeout(() => (this.showCrypto = false), 2000);
          } else {
            this.showCrypto = true;
            this.plus = true;
            setTimeout(() => (this.showUpdate = false), 1000);
            setTimeout(() => (this.showCrypto = false), 2000);
          }
        }
      },
      showAccounts(data) {
        if (data.type === "cash" && !this.showCash) {
          this.showCash = true;
          this.cash = data.cash;
          setTimeout(() => (this.showCash = false), 3500);
        } else if (data.type === "bank" && !this.showBank) {
          this.showBank = true;
          this.bank = data.bank;
          setTimeout(() => (this.showBank = false), 3500);
        }
        if (data.type === "crypto" && !this.showCrypto) {
          this.showCrypto = true;
          this.crypto = data.crypto;
          setTimeout(() => (this.showCrypto = false), 3500);
        }
      },
    },
  }).mount("#money-container");
