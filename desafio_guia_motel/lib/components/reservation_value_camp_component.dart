import 'package:flutter/material.dart';

class ReservationList extends StatelessWidget {
  final List<Map<String, dynamic>> periods; // Lista de períodos com tempo e preço
  final void Function(int index) onReserveTap; // Callback para o botão "Reservar"

  const ReservationList({
    super.key,
    required this.periods,
    required this.onReserveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: periods.map((period) {
        final int index = periods.indexOf(period);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Informações de tempo e preço
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      period['tempoFormatado'] ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (period['desconto'] != null)
                          Text(
                            "R\$ ${period['valorTotal']?.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        if (period['desconto'] != null) const SizedBox(width: 8),
                        Text(
                          "R\$ ${period['valor']?.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: period['desconto'] != null
                                ? Colors.red
                                : Colors.black,
                            decoration: period['desconto'] != null
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Botão de Reservar
              ElevatedButton(
                onPressed: () => onReserveTap(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Reservar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
