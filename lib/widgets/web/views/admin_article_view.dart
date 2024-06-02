import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart' as intl;
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/models/article_model.dart';

TextStyle _defaultStyle = const TextStyle(fontFamily: 'Inter');

class AdminArticleView extends StatefulWidget {
  const AdminArticleView({super.key});

  @override
  State<AdminArticleView> createState() => _AdminArticleViewState();
}

class _AdminArticleViewState extends State<AdminArticleView> {
  int _currentSortColumn = 0;
  bool _isAscending = true;

  void _sort(int columnIndex, bool isAscending) {
    setState(
      () {
        _currentSortColumn = columnIndex;
        _isAscending = isAscending;
      },
    );
  }

  String _getFieldFromIndex(int index) {
    return <String>[
      'title',
      'authorUsername',
      'city',
      'tags',
      'datePublished',
      'dateCreated',
      'isFeatured',
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Modular.get<ArticleModel>().getSortedArticlesStream(
        _getFieldFromIndex(_currentSortColumn),
        isDescending: !_isAscending,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final articles = snapshot.data!;
        return PaginatedDataTable(
          header: Text("Articles", style: _defaultStyle),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Modular.to.pushNamed(createArticleRoute);
              },
            ),
          ],
          rowsPerPage: 9,
          sortColumnIndex: _currentSortColumn,
          sortAscending: _isAscending,
          columns: [
            DataColumn(
                label: Text("Judul", style: _defaultStyle), onSort: _sort),
            DataColumn(
                label: Text("Author", style: _defaultStyle), onSort: _sort),
            DataColumn(
                label: Text("Kota", style: _defaultStyle), onSort: _sort),
            DataColumn(
                label: Text("Tags", style: _defaultStyle), onSort: _sort),
            DataColumn(
                label: Text("Tanggal Publikasi", style: _defaultStyle),
                onSort: _sort),
            DataColumn(
                label: Text("Tanggal Kreasi", style: _defaultStyle),
                onSort: _sort),
            DataColumn(
                label: Text("Apakah di Featured?", style: _defaultStyle),
                onSort: _sort),
            DataColumn(label: Text("Action", style: _defaultStyle)),
          ],
          source: _DataSource(articles, context),
        );
      },
    );
  }
}

class _DataSource extends DataTableSource {
  QuerySnapshot<Map<String, dynamic>> data;
  BuildContext context;

  _DataSource(this.data, this.context);

  @override
  DataRow? getRow(int index) {
    final article = data.docs[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(article['title'], style: _defaultStyle)),
        DataCell(Text(article['authorUsername'], style: _defaultStyle)),
        DataCell(Text(article['city'], style: _defaultStyle)),
        DataCell(Text(article['tags'].join(', '), style: _defaultStyle)),
        DataCell(Text(
          intl.DateFormat.yMd().format(
            article['datePublished'].toDate(),
          ),
          style: _defaultStyle,
        )),
        DataCell(Text(
          intl.DateFormat.yMd().format(
            article['dateCreated'].toDate(),
          ),
          style: _defaultStyle,
        )),
        DataCell(
          Switch(
            value: article['isFeatured'],
            onChanged: (value) {
              Modular.get<ArticleModel>().updateArticleFromId(
                article.id,
                {'isFeatured': value},
              );
            },
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Modular.to
                      .navigate('/admin/article/edit', arguments: article);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Modular.get<ArticleModel>().deleteArticlesFromId(article.id);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.size;

  @override
  int get selectedRowCount => 0;
}
