import 'package:almcq/localization/language_controller.dart';
import 'package:almcq/models/pdf_model.dart';
import 'package:almcq/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ShortNotePage extends StatefulWidget {
  const ShortNotePage({super.key});

  @override
  State<ShortNotePage> createState() => _ShortNotePageState();
}

// Backwards compatibility alias
// ignore: camel_case_types
typedef ShortNote_Page = ShortNotePage;

class _ShortNotePageState extends State<ShortNotePage> {
  static const List<Map<String, dynamic>> notes = [
    {
      'title': 'Logic Gates & Boolean Algebra Laws',
      'category': 'Unit 04 • Digital Logic',
      'icon': Icons.memory_rounded,
      'color': Color(0xFF0D9488),
      'summary':
          'Truth tables for basic (AND, OR, NOT) & universal gates (NAND, NOR). De Morgan\'s Theorems: (A.B)\' = A\' + B\' and (A+B)\' = A\'.B\'. Half adder and full adder logic circuits.',
      'formulaPoints': [
        'Commutative Law: A + B = B + A | A . B = B . A',
        'Distributive Law: A + (B . C) = (A + B) . (A + C)',
        'Absorption Law: A + (A . B) = A | A . (A + B) = A',
        'De Morgan 1: (A . B)\' = A\' + B\'',
        'De Morgan 2: (A + B)\' = A\' . B\'',
      ],
      'pdf': 's',
    },
    {
      'title': 'Number Systems & Base Conversions',
      'category': 'Unit 03 • Data Representation',
      'icon': Icons.pin_outlined,
      'color': Color(0xFF2563EB),
      'summary':
          'Rapid conversion matrix for Binary (Base 2), Octal (Base 8), Decimal (Base 10), and Hexadecimal (Base 16). Signed magnitude and two\'s complement binary subtraction.',
      'formulaPoints': [
        'Hexadecimal digits: 0-9, A(10), B(11), C(12), D(13), E(14), F(15)',
        'Binary to Hex: Group 4 binary bits from right to left',
        'Binary to Octal: Group 3 binary bits from right to left',
        'Two\'s Complement: Invert bits (1\'s complement) and add 1',
        'Range of n-bit 2\'s complement: -2^(n-1) to +(2^(n-1) - 1)',
      ],
      'pdf': 'saa',
    },
    {
      'title': 'SQL Cheatsheet (DDL, DML, DQL)',
      'category': 'Unit 08 • Database Systems',
      'icon': Icons.storage_rounded,
      'color': Color(0xFFEA580C),
      'summary':
          'Essential SQL query syntax for A/L ICT. Table creation with constraints, queries with JOINs, GROUP BY, HAVING, and aggregate functions (COUNT, SUM, AVG, MIN, MAX).',
      'formulaPoints': [
        'DDL: CREATE TABLE tablename (col1 INT PRIMARY KEY, col2 VARCHAR(50));',
        'DML: INSERT INTO tablename VALUES (val1, val2);',
        'DML: UPDATE tablename SET col1 = val WHERE condition;',
        'DQL: SELECT col, COUNT(*) FROM tablename GROUP BY col HAVING COUNT(*) > 1;',
        'Normalization: 1NF (atomic values), 2NF (no partial dependency), 3NF (no transitive dependency)',
      ],
      'pdf': 's',
    },
    {
      'title': 'Python Programming Quick Reference',
      'category': 'Unit 09 • Python Programming',
      'icon': Icons.code_rounded,
      'color': Color(0xFFDC2626),
      'summary':
          'Data types (int, float, str, list, tuple, dict). Slicing rules `[start:stop:step]`. Built-in functions (`len`, `range`, `append`, `pop`). File input/output modes (`r`, `w`, `a`).',
      'formulaPoints': [
        'Lists (mutable): [1, 2, 3] | Tuples (immutable): (1, 2, 3)',
        'Dictionary: {\'key\': \'value\'} accessed via d[\'key\']',
        'String Slicing: s[0:5] extracts characters from index 0 to 4',
        'File Handling: with open(\'file.txt\', \'r\') as f: data = f.read()',
        'Functions: def my_func(arg1, arg2): return arg1 + arg2',
      ],
      'pdf': 'saa',
    },
    {
      'title': 'OSI & TCP/IP Networking Layers',
      'category': 'Unit 06 • Computer Networks',
      'icon': Icons.hub_rounded,
      'color': Color(0xFF16A34A),
      'summary':
          'Comparison of 7-layer OSI model and 4-layer TCP/IP stack. Protocol allocation (HTTP, DNS, TCP, UDP, IP, ARP). IPv4 class ranges, private IPs, and subnet mask calculations.',
      'formulaPoints': [
        'OSI Layers: Application, Presentation, Session, Transport, Network, Data Link, Physical',
        'Transport Layer: TCP (reliable, connection-oriented) vs UDP (fast, connectionless)',
        'Network Layer: IP addressing, routing (Routers work at Layer 3)',
        'Data Link Layer: MAC addressing, framing (Switches work at Layer 2)',
        'Classful IPv4: Class A (1-126), Class B (128-191), Class C (192-223)',
      ],
      'pdf': 's',
    },
    {
      'title': 'SDLC Models & Systems Design',
      'category': 'Unit 07 • Systems Analysis',
      'icon': Icons.account_tree_rounded,
      'color': Color(0xFFD97706),
      'summary':
          'System Development Life Cycle: Identification, Feasibility, Analysis, Design, Implementation, Testing & Maintenance. Waterfall vs Spiral vs Agile models.',
      'formulaPoints': [
        'Feasibility Study: TELOS (Technical, Economic, Legal, Operational, Schedule)',
        'Testing types: Unit Testing, Integration Testing, System Testing, Acceptance Testing',
        'Conversion methods: Direct, Parallel, Pilot, Phased implementation',
        'DFD Symbols: Process (circle/rectangle), Data Store (open rectangle), External Entity (square), Data Flow (arrow)',
      ],
      'pdf': 'saa',
    },
  ];

  void _showNoteDetailModal(Map<String, dynamic> note) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final color = note['color'] as Color;
        final formulaPoints = note['formulaPoints'] as List<String>;

        return Container(
          height: MediaQuery.of(context).size.height * 0.78,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.lightCardBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        Icon(note['icon'] as IconData, color: color, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note['category'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          note['title'] as String,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.lightTextPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('core_summary_theory'),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        note['summary'] as String,
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: AppTheme.lightTextSecondary,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        context.tr('key_formulas_rules'),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...formulaPoints.map(
                        (f) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.lightBackground,
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: AppTheme.lightCardBorder),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.check_circle_outline,
                                  size: 16, color: color),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  f,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.lightTextPrimary,
                                    height: 1.35,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDF_model(
                        pdfname: note['pdf'] as String,
                        title: note['title'] as String,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
                label: Text(context.tr('open_companion_pdf')),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageController.instance,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: AppTheme.lightBackground,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Hero Banner
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color(0xFF2563EB).withValues(alpha: 0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr('short_notes_banner_title'),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              context.tr('short_notes_banner_desc'),
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Colors.white70,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.note_alt_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                Text(
                  context.tr('high_yield_topics'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // Note cards
                ...notes.map((n) {
                  final color = n['color'] as Color;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppTheme.lightCardBorder),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => _showNoteDetailModal(n),
                      borderRadius: BorderRadius.circular(18),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(n['icon'] as IconData,
                                  color: color, size: 24),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    n['category'] as String,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: color,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    n['title'] as String,
                                    style: const TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.lightTextPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    n['summary'] as String,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.lightTextSecondary,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: AppTheme.lightTextSecondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
