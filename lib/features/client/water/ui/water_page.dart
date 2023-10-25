import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaterPage extends StatelessWidget {
  const WaterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('24 Octubre 2023'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.calendar_month_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '2500 ML',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                'Objetivo',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '1000 ML',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                'Restante',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    VerticalSpace.xxxlarge(),
                    Stack(
                      children: [
                        Align(
                          child: Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blue,
                              ),
                            ),
                            child: ClipOval(
                              child: WaveWidget(
                                config: CustomConfig(
                                  colors: [
                                    Colors.blue.withOpacity(.5),
                                    Colors.blue.withOpacity(.9),
                                  ],
                                  durations: [
                                    5000,
                                    4000,
                                  ],
                                  heightPercentages: [
                                    .35,
                                    .36,
                                  ],
                                ),
                                backgroundColor:
                                    Colors.blueGrey.withOpacity(.2),
                                size: Size(double.infinity, double.infinity),
                                wavePhase: 15,
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '60%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '1250 ML',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    VerticalSpace.custom(56),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/images/vaso.png',
                              height: 25,
                            ),
                            label: Text('250 ml'),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(double.infinity, 55),
                            ),
                          ),
                        ),
                        HorizontalSpace.large(),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/images/agua.png',
                              height: 30,
                            ),
                            label: Text('500 ml'),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(double.infinity, 55),
                            ),
                          ),
                        ),
                      ],
                    ),
                    VerticalSpace.large(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/gota-de-agua.png',
                          height: 25,
                        ),
                        label: Text('Otro'),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(double.infinity, 55),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/gota-de-agua.png',
                            height: 25,
                          ),
                        ],
                      ),
                      title: Text('250 ML'),
                      subtitle: Text('24 octubre 2023 13:43'),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.close, color: Colors.red),
                      ),
                      shape: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(.3),
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                    );
                  },
                  childCount: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
