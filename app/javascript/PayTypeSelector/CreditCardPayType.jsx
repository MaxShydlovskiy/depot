import React from 'react'
import {PaymentElement} from '@stripe/react-stripe-js';
class CreditCardPayType extends React.Component {
  render() {
    return (
      <div>
        <form>
          <PaymentElement />
          <button>Submit</button>
        </form>
      </div>
    );
  }
}
export default CreditCardPayType
