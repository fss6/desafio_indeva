import React, { Component } from 'react';
import NumberFormat from 'react-number-format';

export default class DailyGoal extends Component {

  constructor(props) {
    super(props);
    this.state = this.initialState();
    this.handleValue = this.handleValue.bind(this);
    this.handleSellerIds = this.handleSellerIds.bind(this);
  }

  initialState(){
    return {
      value: '',
      goalDate: this.props.date,
      sellerIds: []
    }
  }

  componentDidMount(){
    this.props.callbackAddDailyGoal(this);
  }

  handleValue(e){
    this.setState({ value: e.target.value })
  }

  handleSellerIds(e) {
    let options = [].map.call(e.target.selectedOptions, function (option) {
      return option.value;
    });
    this.setState({ sellerIds: options })
  }

  render(){
    return (
      <div className="well">
        <p>{this.props.date}</p>
        <div className="form-group">
          <NumberFormat
            prefix="R$" thousandSeparator="." decimalSeparator=","
            fixedDecimalScale={true} decimalScale={2} allowNegative={false}
            className='form-control' placeholder='R$ 0,00'
            value={this.state.value}  onValueChange={(values) => {
              const { formattedValue, value } = values;
              this.setState({ value: formattedValue })
            }} />
        </div>
        <div className="form-group">
          <select name='seller_ids' className="form-control"
            multiple="true" onChange={this.handleSellerIds}>
            {this.props.sellers.map((store, k) => (
              <option key={k} value={store.id}>{store.name}</option>
            ))}
          </select>
        </div>
      </div>
    )
  }
}
