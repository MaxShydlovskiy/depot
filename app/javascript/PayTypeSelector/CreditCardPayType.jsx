import React from 'react';
import {Elements} from 'react-stripe-elements';

import InjectedCheckoutForm from './CheckoutForm';

class CreditCardPayType extends React.Component {
  render() {
    return (
      <Elements>
        <InjectedCheckoutForm />
      </Elements>
    );
  }
}

export default CreditCardPayType
