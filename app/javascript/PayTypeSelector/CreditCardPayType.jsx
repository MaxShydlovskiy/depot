import React from 'react'
//import {CardElement} from 'react-stripe-elements';
import {CardElement} from '@stripe/react-stripe-js';
7
class CreditCardPayType extends Compnent {
   handleChange = () => {
   }
  render() {
    return (
      <label>
        Card details
        <CardElement
          id="my-card"
          onChange={this.handleChange}
          options={{
            iconStyle: 'solid',
            style: {
              base: {
                iconColor: '#c4f0ff',
                color: '#fff',
                fontSize: '16px',
              },
              invalid: {
                iconColor: '#FFC7EE',
                color: '#FFC7EE',
              },
            },
          }}
        />;
      </label>
    );
  }
}
export default CreditCardPayType
