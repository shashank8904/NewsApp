import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../viewmodels/newsViewModel.dart';
import '../models/articleModel.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  Future<void> _openUrl(String url, BuildContext ctx) async {
    try {
      final launched = await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Failed to open the article.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
        centerTitle: true,
        elevation: 1,
      ),
      body: Consumer<NewsViewModel>(
        builder: (ctx, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (vm.errorMessage != null) {
            return Center(
              child: Text(vm.errorMessage!, style: theme.textTheme.bodyLarge),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: vm.articles.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (ctx, i) {
              final Article a = vm.articles[i];
              return Card(
                color: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => _openUrl(a.url, ctx),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (a.imageUrl.isNotEmpty)
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            a.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            loadingBuilder: (c, child, prog) =>
                            prog == null
                                ? child
                                : Container(
                              color: Colors.grey[800],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorBuilder: (_, __, ___) =>
                                Container(color: Colors.grey[800], height: 200),
                          ),
                        ),

                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              a.title,
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              a.description,
                              style: theme.textTheme.bodyMedium,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                onPressed: () => _openUrl(a.url, ctx),
                                icon: const Icon(Icons.open_in_new),
                                label: const Text('Read More'),
                                style: TextButton.styleFrom(
                                  foregroundColor: theme.colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
