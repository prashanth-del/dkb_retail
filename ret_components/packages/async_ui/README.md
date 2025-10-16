# async_ui

Tiny UI helpers for Flutter + Riverpod:
- A *single* global blocking overlay while anything is loading
- Future-based views (`RxView`)
- Riverpod `AsyncValue` views (`AsyncView`)

## Install

```yaml
dependencies:
  async_ui:
    path: ../async_ui

# async_ui

Global blocking overlay + AsyncView/RxView for Riverpod apps.

## Setup

```dart
MaterialApp.router(
  builder: (context, child) => GlobalLockUI(child: child ?? const SizedBox()),
);
