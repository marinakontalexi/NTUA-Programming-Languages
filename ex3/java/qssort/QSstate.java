import java.util.*;

public class QSstate implements State {

  private String path;
  private Deque<Integer> queue = new ArrayDeque<>(), stack = new ArrayDeque<>();

  public QSstate(String p, Deque<Integer> q, Deque<Integer> s) {
    path = p;
    queue = q;
    stack = s;
  }

  @Override
  public boolean isFinal() {
    if (!stack.isEmpty()) return false;
    Integer i = queue.getFirst();
    for(Iterator<Integer> itr = queue.iterator(); itr.hasNext();) {
      Integer next = itr.next();
      if (next < i) return false;
      i = next;
    }
    return true;
  }

  @Override
  public Collection<State> next() {
    Collection<State> states = new ArrayList<>();
    Deque<Integer> queueQ = new ArrayDeque<>(), stackQ = new ArrayDeque<>();
    Deque<Integer> queueS = new ArrayDeque<>(), stackS = new ArrayDeque<>();
    for(Iterator<Integer> itr = queue.iterator(); itr.hasNext();) {
      Integer next = itr.next();
      queueQ.add(next); queueS.add(next);
    }
    for(Iterator<Integer> itr = stack.iterator(); itr.hasNext();) {
      Integer next = itr.next();
      stackQ.add(next); stackS.add(next);
    }

    if (!queueQ.isEmpty()) {
      stackQ.addFirst(queueQ.removeFirst());
      states.add(new QSstate(path + "Q", queueQ, stackQ));
    }

    if (!stackS.isEmpty()) {
      if (!queueS.isEmpty() && queueS.getFirst() == stackS.getFirst()) return states;
      queueS.addLast(stackS.removeFirst());
      states.add(new QSstate(path + "S", queueS, stackS));
    }
    return states;
  }

  @Override
  public String getPath() {
    return path;
  }

  // Two states are equal if the contents of the queue and the stack are the same.
  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;
    QSstate other = (QSstate) o;
    Object[] qarr1 = queue.toArray(), qarr2 = other.queue.toArray(),
          sarr1 = stack.toArray(), sarr2 = other.stack.toArray();
    return Arrays.equals(qarr1, qarr2) && Arrays.equals(sarr1, sarr2);
  }

  // Hashing: consider only the contents of the queue and the stack.
  @Override
  public int hashCode() {
    Iterator<Integer> itr1 = queue.iterator();
    Integer i = 1, Q = 0, S = 0;
    while (itr1.hasNext()) {
      Q += itr1.next()*i;
      i *= 3;
    }
    Iterator<Integer> itr2 = stack.iterator();
    i = 1;
    while (itr2.hasNext()) {
      S += itr2.next()*i;
      i *= 5;
    }
    return Q + S;
  }
}
