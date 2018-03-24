# PagosMercado

Esta es una API que permite realizar pagos falsos con tarjetas de crédito hardcodeadas.

Métodos disponibles:

# POST /users
Crea un nuevo usuario con el user y password dados.
data:
```javascript
  {
    :username, :password
  }
```

response ok:
```javascript
  { 
    status: 'success', 
    code: 200, 
    message: 'Usuario creado correctamente'
  }
```

# GET /users
Devuelve el balance de la cuenta dada.

params:
```javascript
  {
    :username, :password
  }
```

response ok:
```javascript
  { 
    status: 'success', 
    code: 200, 
    message: 'Su saldo actual es de {balance}'
  }
```

# POST /start-payment
Toma los datos de la tarjeta y el usuario actual y valida que el pago se pueda realizar correctamente.

data:
```javascript
  {
    :username, :password, :amount, :card_number, :expiration_year, :expiration_month, :name
  }
```
:username y :password deben ser los de un usuario que exista. :expiration_year y :expiration_month deben ser posteriores al mes actual.
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
