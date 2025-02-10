const initializePayjp = () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) 
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#card-number');
  expiryElement.mount('#expiry-date');
  cvcElement.mount('#security-code');

  const form = document.getElementById('purchase-form');
  form.addEventListener("submit", (e) => {
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("purchase-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        document.getElementById("purchase-form").submit();
    });
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", initializePayjp);
window.addEventListener("turbo:render", initializePayjp);
