import React, { Component } from 'react';
import DailyGoal from './DailyGoal';
import NumberFormat from 'react-number-format';

export default class Goal extends Component {

  constructor(props) {
    super(props);
    this.state = this.initialState();
    this.dailyGoals = [];
    this.handleStore = this.handleStore.bind(this);
    this.handleGoalName = this.handleGoalName.bind(this);
    this.handleStartDate = this.handleStartDate.bind(this);
    this.handleEndDate = this.handleEndDate.bind(this);
    this.handleTotalValue = this.handleTotalValue.bind(this);
    this.submitForm = this.submitForm.bind(this);
  }

  initialState() {
    return {
      goalName: '',
      startDate: '',
      endDate: '',
      totalValue: '',
      dailyGoalTotalValue: '',
      storeId: '',
      stores: [],
      sellers: [],
      dailyGoals: []
    };
  }

  datesIsValid(startDateMoment, endDateMoment){
    return startDateMoment.format() <= endDateMoment.format()
      && startDateMoment.isValid()
      && endDateMoment.isValid()
  }

  dailyGoalsVerify(startDateMoment, endDateMoment) {
    if (this.datesIsValid(startDateMoment, endDateMoment)) {
      let newDateMoment = startDateMoment;
      let max = endDateMoment.diff(startDateMoment, 'days') + 1
      this.state.dailyGoals = [];
      for (let i = 0; i < max; i++) {
        this.state.dailyGoals.push({ date: newDateMoment.format('l') })
        newDateMoment.add(1, 'day').format('l');
      }
    }
  }

  getStores(){
    const self = this;
    axios.get('/stores.json')
      .then(response => {
        self.setState({ stores: response.data })
      })
      .catch(error => {
        console.log(error);
      });
  }

  getSellers(storeId) {
    const self = this;
    axios.get('/sellers.json?q%5Bstore_id_eq%5D=' + storeId)
      .then(response => {
        self.setState({ sellers: response.data })
      })
      .catch(error => {
        console.log(error);
      });
  }

  componentDidMount() {
    this.getStores();
    this.getSellers(this.state.storeId);
  }

  handleStore(e) {
    this.setState({ storeId: e.target.value })
    this.getSellers(e.target.value)
  }

  handleGoalName(e) {
    this.setState({ goalName: e.target.value })
  }

  handleStartDate(e) {
    this.setState({ startDate: e.target.value })
    let startDateMoment = moment(e.target.value, 'DD/MM/YYYY');
    console.log('Date: ' + startDateMoment)
    let endDateMoment = moment(this.state.endDate, 'DD/MM/YYYY');
    this.dailyGoalsVerify(startDateMoment, endDateMoment);
  }

  handleEndDate(e) {
    this.setState({ endDate: e.target.value })
    let startDateMoment = moment(this.state.startDate, 'DD/MM/YYYY');
    let endDateMoment = moment(e.target.value, 'DD/MM/YYYY');
    this.dailyGoalsVerify(startDateMoment, endDateMoment);
  }

  handleTotalValue(e) {
    this.setState({ totalValue: e.target.value })
  }

  addDailyGoal(dailyGoal){
    this.dailyGoals.push(dailyGoal)
  }

  attributesMap(){
    return [
      { key: 'store_id', value: 'Loja' },
      { key: 'name', value: 'Nome' },
      { key: 'start_date', value: 'Data de início' },
      { key: 'end_date', value: 'Data de témino' },
      { key: 'daily_goals', value: 'Metas diárias' },
      { key: 'total_value', value: 'Valor Total' }
    ]
  }

  numberFormat(number){
    return number.replace(/\./g, '').replace(/,/g, '.')
      .replace(/R\$/g, '').replace(/' '/g, '');
  }

  submitForm(event) {
    event.preventDefault();

    let { goalName, startDate, endDate, storeId, totalValue } = this.state
    let dailyGoalsAttributes = this.dailyGoals.map( obj => { return {
        value: this.numberFormat(obj.state.value),
        goal_date: obj.state.goalDate,
        seller_ids: obj.state.sellerIds,
      }
    })

    axios.post('/goals.json', {
      goal: {
        store_id: storeId,
        name: goalName,
        start_date: startDate,
        end_date: endDate,
        total_value: this.numberFormat(totalValue),
        daily_goals_attributes: dailyGoalsAttributes
      }
    }).then(response => {
      this.setState(this.initialState())
      toastr.success('Meta cadastrada com sucesso!')
    }).catch(error => {
      this.attributesMap().forEach(element => {
        if (error.response.data.hasOwnProperty(element.key)){
          toastr.error(element.value + " " + error.response.data[element.key])
        }
      });
      console.log(error.response.data)
    })
  }

  render(){
    return (
      <form className='form-horizontal' onSubmit={this.submitForm }>
        <div className="box-body">
          <div className="form-group">
            <label className="col-sm-2 control-label">Loja</label>
            <div className="col-sm-10">
              <select name='store_id' className='form-control'
                onChange={this.handleStore}>
                <option value=''>Selecionar ...</option>
                {this.state.stores.map((store, k) => (
                  <option key={k} value={store.id}>{store.name}</option>
                ))}
              </select>
            </div>
          </div>

          <div className="form-group">
            <label className="col-sm-2 control-label">Nome</label>
            <div className="col-sm-10">
              <input type='text' className='form-control' name="goalName"
                placeholder='Nome' value={this.state.goalName} onChange={this.handleGoalName} />
            </div>
          </div>

          <div className="form-group">
            <label className="col-sm-2 control-label">Data de início</label>
            <div className="col-sm-10">
              <input type='text' className='form-control datemask'
                placeholder='dd/mm/yyyy' value={this.state.startDate} onBlur={this.handleStartDate} />
            </div>
          </div>

          <div className="form-group">
            <label className="col-sm-2 control-label">Data de término</label>
            <div className="col-sm-10">
              <input type='text' className='form-control datemask'
                placeholder='dd/mm/yyyy' value={this.state.endDate} onBlur={this.handleEndDate} />
            </div>
          </div>

          <div className="form-group">
            <label className="col-sm-2 control-label">Valor Total</label>
            <div className="col-sm-10">
              <NumberFormat
                prefix="R$" thousandSeparator="." decimalSeparator=","
                fixedDecimalScale={true} decimalScale={2} allowNegative={false}
                value={this.state.totalValue} onChange={this.handleTotalValue}
                className='form-control' placeholder='R$ 0,00'/>
            </div>
          </div>
        </div>

        <div className="box-footer">
          <h3> Metas Diárias </h3>
          <div className='row'>
            {this.state.dailyGoals.map((item, k) => (
              <div key={k} className='col-md-4'>
                <DailyGoal date={item.date} index={k} sellers={this.state.sellers}
                  callbackAddDailyGoal={ obj => this.addDailyGoal(obj) }/>
              </div>
            ))}
          </div>
        </div>

        <div className="box-footer">
          <a href='/goals' className='btn btn-default'>Voltar</a>
          <button type='submit' className="btn btn-info pull-right">
            Cadastrar
          </button>
        </div>
    </form>
    )
  }
}

