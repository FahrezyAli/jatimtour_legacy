import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart' as intl;

import '../../../constants.dart';
import '../../../models/article_model.dart';
import '../../../services/article_services.dart' as article_services;

TextStyle _defaultStyle = const TextStyle(fontFamily: 'Inter');

class ArticleManagerView extends StatefulWidget {
  const ArticleManagerView({super.key});

  @override
  State<ArticleManagerView> createState() => _ArticleManagerViewState();
}

class _ArticleManagerViewState extends State<ArticleManagerView> {
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
      'authorId',
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
      stream: article_services.getSortedArticlesStream(
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
          columnSpacing: 35.0,
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
                label: Text("Id Author", style: _defaultStyle), onSort: _sort),
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
          source: _DataSource(articles),
        );
      },
    );
  }
}

class _DataSource extends DataTableSource {
  final QuerySnapshot<ArticleModel> _data;

  _DataSource(this._data);

  DataCell _sizedDataCell(Widget child) {
    return DataCell(
      SizedBox(
        width: 100,
        child: child,
      ),
    );
  }

  @override
  DataRow? getRow(int index) {
    final article = _data.docs[index].data();
    return DataRow.byIndex(
      index: index,
      cells: [
        _sizedDataCell(Text(
          article.title,
          style: _defaultStyle,
          overflow: TextOverflow.ellipsis,
        )),
        _sizedDataCell(Text(
          article.authorId,
          style: _defaultStyle,
          overflow: TextOverflow.ellipsis,
        )),
        _sizedDataCell(Text(
          article.city,
          style: _defaultStyle,
          overflow: TextOverflow.ellipsis,
        )),
        _sizedDataCell(Text(
          article.tags.join(', '),
          style: _defaultStyle,
          overflow: TextOverflow.ellipsis,
        )),
        _sizedDataCell(Text(
          intl.DateFormat.yMd().format(
            article.datePublished,
          ),
          style: _defaultStyle,
          overflow: TextOverflow.ellipsis,
        )),
        _sizedDataCell(Text(
          intl.DateFormat.yMd().format(
            article.dateCreated,
          ),
          style: _defaultStyle,
          overflow: TextOverflow.ellipsis,
        )),
        _sizedDataCell(
          Switch(
            value: article.isFeatured,
            onChanged: (value) {
              article_services.updateFeaturedStatus(
                article.id,
                isFeatured: value,
              );
            },
          ),
        ),
        _sizedDataCell(
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
                  article_services.deleteArticle(article.id);
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
  int get rowCount => _data.size;

  @override
  int get selectedRowCount => 0;
}
