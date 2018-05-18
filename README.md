# PagosMercado

Esta es una API que permite realizar pagos falsos con tarjetas de crédito hardcodeadas.
Se puede encontrar en https://pagosmercado.herokuapp.com/.

Métodos disponibles:

# POST /start-payment
Toma los datos de la tarjeta y el usuario actual y valida que el pago se pueda realizar correctamente.

data:
```javascript
  {
    :amount, :card_number, :expiration_year, :expiration_month, :name
  }
```
:expiration_year y :expiration_month deben ser posteriores al mes actual.
:card_number debe ser `4509953566233704` y :name debe ser `APRO`.

response ok:
```javascript
  {
    status: 'success', 
    code: 200, 
    message: 'La operacion se inicio con exito', 
    data: 
      { 
        token: token
      }
  }
```
:token sera el identificador de la operacion.

# POST /credit-payment
Toma el token de la operacion y un amount (que debe ser igual al inicial), y completa el pago. Eso incrementa el balance del usuario.

data:
```javascript
  {
    :token, :amount
  }
```

response ok:
```javascript
  {
    status: 'success', 
    code: 200, 
    message: 'El pago se realizo exitosamente!'
  }
```
