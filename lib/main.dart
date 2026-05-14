import 'package:flutter/material.dart';

void main() {
  runApp(const DatingPrototypeApp());
}

class DatingPrototypeApp extends StatelessWidget {
  const DatingPrototypeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mingle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE85D75),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFCFAF7),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const ShellScreen(),
    );
  }
}

class ProfileCandidate {
  const ProfileCandidate({
    required this.name,
    required this.age,
    required this.job,
    required this.distance,
    required this.bio,
    required this.matchRate,
    required this.color,
    required this.interests,
  });

  final String name;
  final int age;
  final String job;
  final String distance;
  final String bio;
  final int matchRate;
  final Color color;
  final List<String> interests;
}

class ChatPreview {
  const ChatPreview({
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.color,
  });

  final String name;
  final String message;
  final String time;
  final int unread;
  final Color color;
}

const candidates = [
  ProfileCandidate(
    name: '서윤',
    age: 29,
    job: '브랜드 마케터',
    distance: '1.8km',
    bio: '주말엔 전시를 보고, 평일 밤에는 재즈 플레이리스트를 정리해요.',
    matchRate: 94,
    color: Color(0xFFE85D75),
    interests: ['전시', '와인', '러닝'],
  ),
  ProfileCandidate(
    name: '하린',
    age: 31,
    job: '프로덕트 디자이너',
    distance: '3.2km',
    bio: '낯선 동네 산책과 맛있는 커피를 좋아합니다. 대화가 잘 통하는 사람이 좋아요.',
    matchRate: 89,
    color: Color(0xFF4D96FF),
    interests: ['커피', '산책', '영화'],
  ),
  ProfileCandidate(
    name: '지우',
    age: 28,
    job: '데이터 분석가',
    distance: '4.6km',
    bio: '퇴근 후 클라이밍, 쉬는 날엔 조용한 책방. 새로운 취향을 같이 발견하고 싶어요.',
    matchRate: 86,
    color: Color(0xFF00A896),
    interests: ['클라이밍', '책방', '요리'],
  ),
];

const chats = [
  ChatPreview(
    name: '서윤',
    message: '이번 주말에 성수 전시 같이 볼래요?',
    time: '방금',
    unread: 2,
    color: Color(0xFFE85D75),
  ),
  ChatPreview(
    name: '하린',
    message: '그 카페 저도 저장해뒀어요.',
    time: '12:42',
    unread: 0,
    color: Color(0xFF4D96FF),
  ),
  ChatPreview(
    name: '지우',
    message: '클라이밍은 처음이어도 괜찮아요.',
    time: '어제',
    unread: 1,
    color: Color(0xFF00A896),
  ),
];

const discoverFilters = ['추천', '근처', '새 가입', '취향 매칭'];

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const DiscoverScreen(),
      const MatchesScreen(),
      const ChatsScreen(),
      const MyProfileScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.style_outlined),
            selectedIcon: Icon(Icons.style),
            label: '탐색',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: '매칭',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: '채팅',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _activeIndex = 0;
  String _selectedFilter = '추천';

  ProfileCandidate get active => candidates[_activeIndex % candidates.length];

  void _nextCard({required bool liked}) {
    if (liked) {
      _showMatchSheet(active);
    }

    setState(() {
      _activeIndex = (_activeIndex + 1) % candidates.length;
    });
  }

  void _showMatchSheet(ProfileCandidate profile) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: const Color(0xFFFCFAF7),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 38,
                backgroundColor: profile.color,
                child: Text(
                  profile.name.substring(0, 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                '${profile.name}님에게 호감을 보냈어요',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '상대도 좋아요를 누르면 바로 대화를 시작할 수 있습니다.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF6F6767),
                    ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.check),
                  label: const Text('확인'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mingle',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '오늘 당신과 잘 맞는 사람',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF7A7070),
                        ),
                  ),
                ],
              ),
            ),
            IconButton.filledTonal(
              onPressed: () {},
              tooltip: '알림',
              icon: const Icon(Icons.notifications_none),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: () {},
              tooltip: '필터',
              icon: const Icon(Icons.tune),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: discoverFilters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final filter = discoverFilters[index];
              return ChoiceChip(
                label: Text(filter),
                selected: _selectedFilter == filter,
                onSelected: (_) => setState(() => _selectedFilter = filter),
              );
            },
          ),
        ),
        const SizedBox(height: 18),
        GestureDetector(
          onHorizontalDragEnd: (details) {
            final velocity = details.primaryVelocity ?? 0;
            if (velocity < -120) {
              _nextCard(liked: false);
            } else if (velocity > 120) {
              _nextCard(liked: true);
            }
          },
          child: CandidateCard(profile: active),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(
              icon: Icons.close,
              color: const Color(0xFF5C6670),
              tooltip: '패스',
              onPressed: () => _nextCard(liked: false),
            ),
            const SizedBox(width: 18),
            ActionButton(
              icon: Icons.favorite,
              color: const Color(0xFFE85D75),
              tooltip: '좋아요',
              onPressed: () => _nextCard(liked: true),
              large: true,
            ),
            const SizedBox(width: 18),
            ActionButton(
              icon: Icons.star,
              color: const Color(0xFFFFB703),
              tooltip: '슈퍼 좋아요',
              onPressed: () => _nextCard(liked: true),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const SectionHeader(title: '오늘의 추천 포인트'),
        const SizedBox(height: 10),
        const InsightPanel(),
      ],
    );
  }
}

class CandidateCard extends StatelessWidget {
  const CandidateCard({super.key, required this.profile});

  final ProfileCandidate profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            profile.color.withOpacity(0.96),
            const Color(0xFF22223B),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: profile.color.withOpacity(0.26),
            blurRadius: 28,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 22,
            left: 22,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified, color: Colors.white, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    '${profile.matchRate}% 매칭',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 184,
              height: 184,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.18),
                border: Border.all(color: Colors.white.withOpacity(0.36)),
              ),
              child: Center(
                child: Text(
                  profile.name.substring(0, 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 84,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        '${profile.name}, ${profile.age}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    Text(
                      profile.distance,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  profile.job,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  profile.bio,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.86),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: profile.interests
                      .map(
                        (interest) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.16),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            interest,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onPressed,
    this.large = false,
  });

  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onPressed;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final size = large ? 72.0 : 58.0;
    return SizedBox(
      width: size,
      height: size,
      child: IconButton.filled(
        onPressed: onPressed,
        tooltip: tooltip,
        style: IconButton.styleFrom(backgroundColor: color),
        icon: Icon(icon, size: large ? 32 : 26),
      ),
    );
  }
}

class InsightPanel extends StatelessWidget {
  const InsightPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF0E6E2)),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE3A3),
                borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.auto_awesome, color: Color(0xFF9A6700)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '취향 겹침이 높은 시간대',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '오늘 19:00 이후 활동 중인 후보와 매칭 확률이 높습니다.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF6F6767),
                        height: 1.35,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      children: [
        const PageTitle(title: '매칭', subtitle: '서로 호감을 보낸 사람들'),
        const SizedBox(height: 18),
        const SectionHeader(title: '새로운 매칭'),
        const SizedBox(height: 12),
        SizedBox(
          height: 128,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: candidates.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final profile = candidates[index];
              return MatchBubble(profile: profile);
            },
          ),
        ),
        const SizedBox(height: 22),
        const SectionHeader(title: '받은 좋아요'),
        const SizedBox(height: 12),
        ...candidates.map((profile) => LikeTile(profile: profile)),
      ],
    );
  }
}

class MatchBubble extends StatelessWidget {
  const MatchBubble({super.key, required this.profile});

  final ProfileCandidate profile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      child: Column(
        children: [
          CircleAvatar(
            radius: 38,
            backgroundColor: profile.color,
            child: Text(
              profile.name.substring(0, 1),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            profile.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          Text(
            '${profile.matchRate}%',
            style: const TextStyle(color: Color(0xFFE85D75)),
          ),
        ],
      ),
    );
  }
}

class LikeTile extends StatelessWidget {
  const LikeTile({super.key, required this.profile});

  final ProfileCandidate profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF0E6E2)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: profile.color,
            child: Text(
              profile.name.substring(0, 1),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profile.name}, ${profile.age}',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 3),
                Text(
                  '${profile.job} · ${profile.distance}',
                  style: const TextStyle(color: Color(0xFF766B6B)),
                ),
              ],
            ),
          ),
          IconButton.filledTonal(
            onPressed: () {},
            tooltip: '프로필 보기',
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      children: [
        const PageTitle(title: '채팅', subtitle: '매칭 후 시작된 대화'),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: '이름 또는 대화 검색',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 18),
        ...chats.map((chat) => ChatTile(chat: chat)),
      ],
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.chat});

  final ChatPreview chat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ConversationScreen(chat: chat),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFF0E6E2)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: chat.color,
              child: Text(
                chat.name.substring(0, 1),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.name,
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                      Text(
                        chat.time,
                        style: const TextStyle(
                          color: Color(0xFF766B6B),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.message,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Color(0xFF766B6B)),
                  ),
                ],
              ),
            ),
            if (chat.unread > 0) ...[
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 12,
                backgroundColor: const Color(0xFFE85D75),
                child: Text(
                  '${chat.unread}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key, required this.chat});

  final ChatPreview chat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFAF7),
      appBar: AppBar(
        title: Text(chat.name),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: '통화',
            icon: const Icon(Icons.call_outlined),
          ),
          IconButton(
            onPressed: () {},
            tooltip: '더보기',
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                MessageBubble(
                  text: '안녕하세요! 프로필에 전시 좋아한다고 되어 있던데요.',
                  mine: false,
                ),
                MessageBubble(
                  text: '맞아요. 요즘은 사진전 쪽을 자주 봐요.',
                  mine: true,
                ),
                MessageBubble(
                  text: '이번 주말에 성수 전시 같이 볼래요?',
                  mine: false,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  tooltip: '첨부',
                  icon: const Icon(Icons.add_circle_outline),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '메시지 입력',
                      filled: true,
                      fillColor: const Color(0xFFF6F1EF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(99),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: () {},
                  tooltip: '전송',
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.text, required this.mine});

  final String text;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: mine ? const Color(0xFFE85D75) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: mine ? null : Border.all(color: const Color(0xFFF0E6E2)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: mine ? Colors.white : const Color(0xFF262323),
            height: 1.35,
          ),
        ),
      ),
    );
  }
}

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      children: [
        const PageTitle(title: '내 프로필', subtitle: '매칭 품질을 높이는 정보'),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFF0E6E2)),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 42,
                backgroundColor: Color(0xFF22223B),
                child: Text(
                  '나',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '민준, 32',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '앱 기획자 · 서울 마포구',
                      style: TextStyle(color: Color(0xFF766B6B)),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: 0.82,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '프로필 완성도 82%',
                      style: TextStyle(
                        color: Color(0xFFE85D75),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const SectionHeader(title: '선호 조건'),
        const SizedBox(height: 10),
        const PreferenceTile(
          icon: Icons.location_on_outlined,
          title: '거리',
          value: '10km 이내',
        ),
        const PreferenceTile(
          icon: Icons.cake_outlined,
          title: '나이',
          value: '27-36세',
        ),
        const PreferenceTile(
          icon: Icons.interests_outlined,
          title: '관심사',
          value: '전시, 커피, 러닝',
        ),
        const SizedBox(height: 18),
        const SectionHeader(title: '설정'),
        const SizedBox(height: 10),
        SwitchListTile(
          value: true,
          onChanged: (_) {},
          title: const Text('푸시 알림'),
          subtitle: const Text('새 매칭과 메시지 알림 받기'),
          secondary: const Icon(Icons.notifications_active_outlined),
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}

class PreferenceTile extends StatelessWidget {
  const PreferenceTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF0E6E2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFE85D75)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Color(0xFF766B6B)),
          ),
        ],
      ),
    );
  }
}

class PageTitle extends StatelessWidget {
  const PageTitle({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 0,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF7A7070),
              ),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
          ),
    );
  }
}
