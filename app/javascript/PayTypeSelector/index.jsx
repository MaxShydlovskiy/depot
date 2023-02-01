import React from 'react'

import NoPayType from './NoPayType';
import CreditCardPayType from './CreditCardPayType';
import CheckPayType from './CheckPayType';
import PurchaseOrderPayType from './PurchaseOrderPayType';
import {Elements} from '@stripe/react-stripe-js';
import {CardElement} from '@stripe/react-stripe-js';
import {loadStripe} from '@stripe/stripe-js';

// Make sure to call `loadStripe` outside of a component’s render to avoid
// recreating the `Stripe` object on every render.
const stripePromise = loadStripe('pk_test_51MUXrmLzcHKkPnpTf4OABSZ1zX9PipalZtRxc3fDJ5laxLuz8KZy3U8Co7AdmMgbL8dGC9RLeAIYfty5WgaOIRwc00Kv874RWY');

const options = {
  // passing the client secret obtained from the server
  clientSecret: '{{CLIENT_SECRET}}',
};

class PayTypeSelector extends React.Component {

  constructor(props) {
    super(props);
    this.onPayTypeSelected = this.onPayTypeSelected.bind(this);
    this.state = { selectedPayType: null };
  }

  onPayTypeSelected(event) {
    this.setState({ selectedPayType: event.target.value });
  }

  render() {
    let PayTypeCustomComponent = NoPayType;
    if (this.state.selectedPayType == "Credit card") {
      PayTypeCustomComponent = CreditCardPayType;
    } else if (this.state.selectedPayType == "Check") {
      PayTypeCustomComponent = CheckPayType;
    } else if (this.state.selectedPayType == "Purchase order") {
      PayTypeCustomComponent = PurchaseOrderPayType;
    }
    return (
      <div>
        <div className="field">
          <label htmlFor="order_pay_type">
            {I18n.t("orders.form.pay_type")}
          </label>

          <select id="order_pay_type" onChange={this.onPayTypeSelected}
            name="order[pay_type]">

            <option value="">
              {I18n.t("orders.form.pay_prompt_html")}
            </option>

            <option value="Check">
              {I18n.t("orders.form.pay_types.check")}
            </option>

            <Elements stripe={stripePromise} value="Credit Card">
            <CardElement />
            </Elements>

            <option value="Purchase order">
              {I18n.t("orders.form.pay_types.purchase_order")}
            </option>

          </select>
        </div>
        <PayTypeCustomComponent />
      </div>
    );
  }
}
export default PayTypeSelector
