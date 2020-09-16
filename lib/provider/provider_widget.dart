import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ProviderWidget 封装
class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;
  final Widget child;
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelInitial;

  ProviderWidget({
    Key key,
    this.model,
    this.child,
    this.builder,
    this.onModelInitial,
  });

  @override
  ProviderWidgetState<T> createState() => ProviderWidgetState<T>();
}

class ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  T model;

  @override
  void initState() {
    super.initState();
    this.model = widget.model;
    if (widget.onModelInitial != null) {
      widget.onModelInitial(this.model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => this.model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
  builder;
  final A model1;
  final B model2;
  final Widget child;
  final Function(A, B) onModelInitial;

  ProviderWidget2({
    Key key,
    this.builder,
    this.model1,
    this.model2,
    this.child,
    this.onModelInitial,
  }) : super(key: key);

  _ProviderWidgetState2<A, B> createState() => _ProviderWidgetState2<A, B>();
}

class _ProviderWidgetState2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget2<A, B>> {
  A model1;
  B model2;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;

    if (widget.onModelInitial != null) {
      widget.onModelInitial(model1, model2);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>(
            create: (context) => model1,
          ),
          ChangeNotifierProvider<B>(
            create: (context) => model2,
          )
        ],
        child: Consumer2<A, B>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}

class ProviderWidget3<A extends ChangeNotifier, B extends ChangeNotifier,C extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, C model3, Widget child)
  builder;
  final A model1;
  final B model2;
  final C model3;
  final Widget child;
  final Function(A, B, C) onModelInitial;

  ProviderWidget3({
    Key key,
    this.builder,
    this.model1,
    this.model2,
    this.model3,
    this.child,
    this.onModelInitial,
  }) : super(key: key);

  _ProviderWidgetState3<A, B,C> createState() => _ProviderWidgetState3<A, B,C>();
}

class _ProviderWidgetState3<A extends ChangeNotifier, B extends ChangeNotifier,C extends ChangeNotifier>
    extends State<ProviderWidget3<A, B,C>> {
  A model1;
  B model2;
  C model3;
  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;
    model3 = widget.model3;
    if (widget.onModelInitial != null) {
      widget.onModelInitial(model1, model2,model3);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>(
            create: (context) => model1,
          ),
          ChangeNotifierProvider<B>(
            create: (context) => model2,
          ),
          ChangeNotifierProvider<C>(
            create: (context) => model3,
          )
        ],
        child: Consumer3<A, B,C>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}
class ProviderWidget4<A extends ChangeNotifier, B extends ChangeNotifier,C extends ChangeNotifier,D extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, C model3,D model4, Widget child)
  builder;
  final A model1;
  final B model2;
  final C model3;
  final D model4;
  final Widget child;
  final Function(A, B, C,D) onModelInitial;

  ProviderWidget4({
    Key key,
    this.builder,
    this.model1,
    this.model2,
    this.model3,
    this.model4,
    this.child,
    this.onModelInitial,
  }) : super(key: key);

  _ProviderWidgetState4<A, B,C,D> createState() => _ProviderWidgetState4<A, B,C,D>();
}

class _ProviderWidgetState4<A extends ChangeNotifier, B extends ChangeNotifier,C extends ChangeNotifier,D extends ChangeNotifier>
    extends State<ProviderWidget4<A, B,C,D>> {
  A model1;
  B model2;
  C model3;
  D model4;
  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;
    model3 = widget.model3;
    model4 = widget.model4;
    if (widget.onModelInitial != null) {
      widget.onModelInitial(model1, model2,model3,model4);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>(
            create: (context) => model1,
          ),
          ChangeNotifierProvider<B>(
            create: (context) => model2,
          ),
          ChangeNotifierProvider<C>(
            create: (context) => model3,
          ),
          ChangeNotifierProvider<D>(
            create: (context) => model4,
          )
        ],
        child: Consumer4<A, B,C,D>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}