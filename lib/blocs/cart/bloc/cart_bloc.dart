import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_test/models/cart.dart';
import 'package:ecommerce_app_test/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<StartCart>((event, emit) async {
      emit(CartLoading());
      try {
        await Future<void>.delayed(const Duration(seconds: 1));
        emit(const CartLoaded());
      } catch (_) {
        emit(CartError());
      }
    });

    on<AddCart>((event, emit) async {
      final state = this.state;
      if (state is CartLoaded) {
        try {
          emit(CartLoaded(
            cart: Cart(
              products: List.from(state.cart.products)..add(event.product),
            ),
          ));
        } on Exception {
          emit(CartError());
        }
      }
    });

    on<RemoveCart>((event, emit) async {
      final state = this.state;
      if (state is CartLoaded) {
        try {
          emit(CartLoaded(
            cart: Cart(
              products: List.from(state.cart.products)..remove(event.product),
            ),
          ));
        } on Exception {
          emit(CartError());
        }
      }
    });
  }

/*  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CartStarted) {
      yield* _mapCartStartedToState();
    } else if (event is CartProductAdded) {
      yield* _mapCartProductAddedToState(event, state);
    } else if (event is CartProductRemoved) {
      yield* _mapCartProductRemovedToState(event, state);
    }
  }

  Stream<CartState> _mapCartStartedToState() async* {
    yield CartLoading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield const CartLoaded();
    } catch (_) {
      yield CartError();
    }
  }

  Stream<CartState> _mapCartProductAddedToState(
    CartProductAdded event,
    CartState state,
  ) async* {
    if (state is CartLoaded) {
      try {
        yield CartLoaded(
          cart: Cart(
            products: List.from(state.cart.products)..add(event.product),
          ),
        );
      } on Exception {
        yield CartError();
      }
    }
  }

  Stream<CartState> _mapCartProductRemovedToState(
    CartProductRemoved event,
    CartState state,
  ) async* {
    if (state is CartLoaded) {
      try {
        yield CartLoaded(
          cart: Cart(
            products: List.from(state.cart.products)..remove(event.product),
          ),
        );
      } on Exception {
        yield CartError();
      }
    }
  }*/
}
