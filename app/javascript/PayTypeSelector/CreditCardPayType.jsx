import React from 'react'
//import {CardElement} from 'react-stripe-elements';
import {CardElement} from '@stripe/react-stripe-js';
class CreditCardPayType extends React.Component {
  render() {
    return (
      <label>
        Card details
        <CardElement
          id="my-card"
          onChange={handleChange}
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
