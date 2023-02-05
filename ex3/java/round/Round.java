import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class Round {
  // The main function.
  public static void main(String args[]) {

    File inFile = new File(args[0]);
    try {
      Scanner scanner = new Scanner(inFile);
      int Cities = scanner.nextInt(), Cars = scanner.nextInt(), i, c = 0, counter = 0;
      int[] positions = new int[Cars], cities = new int[Cities], furthest = new int[Cities];
      for (i = 0; i < Cars; i++)
        positions[i] = scanner.nextInt();
      Arrays.sort(positions);

      //switch to cities array
      i = 0;
      while (i < Cars) {
        if (positions[i] == c) {
          counter++;
          i++;
        }
        else {
          cities[c++] = counter;
          counter = 0;
        }
      }
      cities[c++] = counter;
      while (c < Cities) cities[c++] = 0;

      //find the car furthest away from target
      //-2 means the car furthest away won't cause problems
      c = 1; i = 0;
      while (++i < 2*Cities)
        if (cities[i % Cities] == 0) c++;
        else if (cities[i % Cities] == 1) {
          while (c > 0) furthest[(i - c--) % Cities] = i % Cities;
          c = 1;
        }
        else {
          while (c > 0) furthest[(i - c--) % Cities] = -2;
          c = 1;
        }

      //compute distances for city 0
      int firstsum = 0, currentmin, far = Cities - furthest[0], target = 0;
      for (i = 1; i < Cities; i++)
        firstsum += cities[i]*(Cities - i);
      if (furthest[0] < 0 || firstsum - far + 1 >= furthest[0]) currentmin = firstsum;
      else currentmin = firstsum + (2 - ((far - (firstsum - far) + 1)/Cities))*Cities;

      //compute rest of distances
      int prevdist = firstsum;
      for (i = 1; i < Cities; i++) {
        int newdist = prevdist + Cars - cities[i]*Cities;
        far = (Cities + i - furthest[i]) % Cities;

        if (furthest[i] < 0 || newdist - far + 1 >= far) {
          if (newdist < currentmin) {
            currentmin = newdist;
            target = i;
          }
        }
        else if (furthest[i] >= 0 && newdist + (2 - (far - (newdist - far) + 1)/Cities)*Cities < currentmin) {
          currentmin = newdist + (2 - ((far - (newdist - far) + 1)/Cities))*Cities;
          target = i;
        }
        prevdist = newdist;
      }
      System.out.println(currentmin + " " + target);
    }
    catch (FileNotFoundException e) {
        e.printStackTrace();
    }
  }
}
