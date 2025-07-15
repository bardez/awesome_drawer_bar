# Flutter Awesome Drawer Bar

[![pub package](https://img.shields.io/pub/v/awesome_drawer_bar.svg)](https://pub.dev/packages/awesome_drawer_bar) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter package with custom implementation of the Side Menu (Drawer)

## Getting Started

To start using this package, add `awesome_drawer_bar` dependency to your `pubspec.yaml`

```yaml
dependencies:
  awesome_drawer_bar: "<latest_release>"
```

## Features

- Simple sliding drawer
- Sliding drawer with shadows
- Sliding drawer with rotation
- Sliding drawer with rotation and shadows
- Support for both LTR & RTL

## Documentation

```dart
    AwesomeDrawerBar(
      controller: AwesomeDrawerBarController,
      menuScreen: MENU_SCREEN,
      mainScreen: MAIN_SCREEN,
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      backgroundColor: Colors.grey[300],
      slideWidth: MediaQuery.of(context).size.width*.65,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    )
```

| Parameters           | Value                        | Required | Docs                                                                                     |
| -------------------- | ---------------------------- | :------: | ---------------------------------------------------------------------------------------- |
| `controller`         | `AwesomeDrawerBarController` |    No    | Controller to have access to the open/close/toggle function of the drawer                |
| `mainScreen`         | `Widget`                     |   Yes    | Screen containing the main content to display                                            |
| `menuScreen`         | `Widget`                     |   Yes    | Screen containing the menu/bottom screen                                                 |
| `slideWidth`         | `double`                     |    No    | Sliding width of the drawer - defaults to 275.0                                          |
| `borderRadius`       | `double`                     |    No    | Border radius of the slided content - defaults to 16.0                                   |
| `angle`              | `double`                     |    No    | Rotation angle of the drawer - defaults to -12.0 - should be 0.0 to -30.0                |
| `backgroundColor`    | `Color`                      |    No    | Background color of the drawer shadows - defaults to white                               |
| `showShadow`         | `bool`                       |    No    | Boolean, whether to show the drawer shadows - defaults to false                          |
| `openCurve`          | `Curve`                      |    No    | open animation curve - defaults to `Curves.easeOut`                                      |
| `closeCurve`         | `Curve`                      |    No    | close animation curve - defaults to `Curves.easeOut`                                     |
| `isSwipeEnabled`     | `bool`                       |    No    | Boolean to control if swipe is enabled globally - defaults to true                       |
| `swipeEnabledRoutes` | `List<String>?`              |    No    | List of route names where swipe is enabled (if null, swipe is enabled everywhere)        |
| `getCurrentRoute`    | `String? Function()?`        |    No    | Function to get the current route name - useful for custom routing systems like GoRouter |

### Controlling the drawer

To get access to the drawer, and be able to control it, there are 2 ways:

- Using a `AwesomeDrawerBarController` inside the main widget where ou have the `AwesomeDrawerBar` widget and providing it to the widget, which will allow you to trigger the open/close/toggle methods.

```dart
    final _drawerController = AwesomeDrawerBarController();

    _drawerController.open();
    _drawerController.close();
    _drawerController.toggle();
    _drawerController.isOpen();
    _drawerController.stateNotifier;
```

- Using the static method inside ancestor widgets to get access to the `AwesomeDrawerBar`.

```dart
  AwesomeDrawerBar.of(context).open();
  AwesomeDrawerBar.of(context).close();
  AwesomeDrawerBar.of(context).toggle();
  AwesomeDrawerBar.of(context).isOpen();
  AwesomeDrawerBar.of(context).stateNotifier;
```

## Controle de Swipe por Rota

O `AwesomeDrawerBar` permite controlar quando o swipe para abrir o menu está habilitado, baseado na rota atual. Isso é útil para desabilitar o swipe em telas específicas onde você quer que o swipe natural do sistema (como o gesto de voltar no iOS) funcione normalmente.

### Propriedades de Controle

- `isSwipeEnabled` (bool): Habilita/desabilita o controle de swipe por rota
- `swipeEnabledRoutes` (List<String>?): Lista de rotas onde o swipe está habilitado
- `getCurrentRoute` (String Function()?): Callback para obter a rota atual (útil para sistemas de roteamento customizados)

### Comportamento

**Quando o swipe está habilitado para a rota atual:**

- O swipe na borda da tela (20px) abre o menu
- O swipe no menu aberto fecha o menu
- Outros gestos do sistema continuam funcionando normalmente

**Quando o swipe está desabilitado para a rota atual:**

- Nenhum detector de gesto é adicionado para o menu
- O swipe natural do sistema (como o gesto de voltar no iOS) funciona normalmente
- O menu só pode ser aberto programaticamente (botão, etc.)

### Exemplos de Uso

#### 1. Desabilitar swipe em rotas específicas

```dart
AwesomeDrawerBar(
  controller: _drawerController,
  mainScreen: MyHomePage(),
  menuScreen: Sidebar(),
  isSwipeEnabled: true,
  swipeEnabledRoutes: const [
    '/home',
    '/profile'
  ], // Apenas estas rotas terão swipe habilitado
)
```

#### 2. Desabilitar swipe completamente

```dart
AwesomeDrawerBar(
  controller: _drawerController,
  mainScreen: MyHomePage(),
  menuScreen: Sidebar(),
  isSwipeEnabled: false, // Desabilita swipe em todas as rotas
)
```

#### 3. Habilitar swipe em todas as rotas

```dart
AwesomeDrawerBar(
  controller: _drawerController,
  mainScreen: MyHomePage(),
  menuScreen: Sidebar(),
  isSwipeEnabled: true,
  swipeEnabledRoutes: null, // Habilita swipe em todas as rotas
)
```

#### 4. Com GoRouter

```dart
AwesomeDrawerBar(
  controller: _drawerController,
  mainScreen: MyHomePage(),
  menuScreen: Sidebar(),
  isSwipeEnabled: true,
  swipeEnabledRoutes: const ['/home', '/profile'],
  getCurrentRoute: () {
    return GoRouter.of(context).location;
  },
)
```

#### 5. Com roteamento customizado

```dart
AwesomeDrawerBar(
  controller: _drawerController,
  mainScreen: MyHomePage(),
  menuScreen: Sidebar(),
  isSwipeEnabled: true,
  swipeEnabledRoutes: const ['/home', '/profile'],
  getCurrentRoute: () {
    return MyCustomRouter.getCurrentRoute();
  },
)
```

### Notas Importantes

- **Swipe Natural do Sistema**: Quando o swipe do menu está desabilitado, nenhum detector de gesto interfere com os gestos naturais do sistema (como o swipe de voltar no iOS)
- **Borda da Tela**: O swipe para abrir o menu só funciona na borda da tela (20px), não interferindo com gestos no centro da tela
- **Performance**: Não há impacto na performance quando o swipe está desabilitado, pois nenhum detector de gesto é adicionado
- **Compatibilidade**: Funciona com qualquer sistema de roteamento (GoRouter, AutoRoute, roteamento customizado, etc.)

## Screens

![Example app Demo](https://drive.google.com/uc?export=view&id=1xc6XwVVtpl0RK9IJEdheagM4d1ychQms)

![Example RTL Demo](https://drive.google.com/uc?export=view&id=1YLC60zJ6N637PB6IQDo4TIXY1qGSJ2ET)

- Drawer Sliding

```dart
    AwesomeDrawerBar(
      controller: AwesomeDrawerBarController,
      menuScreen: MENU_SCREEN,
      mainScreen: MAIN_SCREEN,
      borderRadius: 24.0,
      showShadow: false,
      angle: 0.0,
      backgroundColor: Colors.grey[300],
      slideWidth: MediaQuery.of(context).size.width*(AwesomeDrawerBar.isRTL()? .45: 0.65),
    )
```

![Drawer Sliding](https://drive.google.com/uc?export=view&id=1axuT4Geh08s_QjmED9VTZiwZ9dC_C17C)

- Drawer Sliding with shadow

```dart
    AwesomeDrawerBar(
      controller: AwesomeDrawerBarController,
      menuScreen: MENU_SCREEN,
      mainScreen: MAIN_SCREEN,
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      backgroundColor: Colors.grey[300],
      slideWidth: MediaQuery.of(context).size.width*(AwesomeDrawerBar.isRTL()? .45: 0.65),
    )
```

![Drawer Sliding](https://drive.google.com/uc?export=view&id=1VNkUgtj_bhyYgWJ_Bs3yUpVNUJ30ToPL)

- Drawer Sliding with rotation

```dart
    AwesomeDrawerBar(
      controller: AwesomeDrawerBarController,
      menuScreen: MENU_SCREEN,
      mainScreen: MAIN_SCREEN,
      borderRadius: 24.0,
      showShadow: false,
      angle: -12.0,
      backgroundColor: Colors.grey[300],
      slideWidth: MediaQuery.of(context).size.width*(AwesomeDrawerBar.isRTL()? .45: 0.65),
    )
```

![Drawer Sliding with rotation](https://drive.google.com/uc?export=view&id=1xVYoZHnS9BFi5KicZtP3DY1vEiwZ4FyH)

- Drawer Sliding with rotation and shadows

```dart
    AwesomeDrawerBar(
      controller: AwesomeDrawerBarController,
      menuScreen: MENU_SCREEN,
      mainScreen: MAIN_SCREEN,
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      backgroundColor: Colors.grey[300],
      slideWidth: MediaQuery.of(context).size.width*(AwesomeDrawerBar.isRTL()? .45: 0.65),
    )
```

![Drawer Sliding with rotation and shadows](https://drive.google.com/uc?export=view&id=1b-U25tIY36ka75Ju2jQT9BIUVHv-oNe6)

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/medyas/awesome_drawer_bar/issues) page.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](CONTRIBUTING.md) and send us your [pull request](https://github.com/medyas/awesome_drawer_bar/pulls).

## Credits

Credits goes to [pedromassango](https://github.com/pedromassango/flutter_delivery) as most of this package comes from his implementation.
