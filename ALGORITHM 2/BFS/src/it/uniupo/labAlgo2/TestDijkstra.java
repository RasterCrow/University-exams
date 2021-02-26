package it.uniupo.labAlgo2;

import static org.junit.Assert.assertEquals;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

import it.uniupo.graphLib.*;

class TestDijkstra {
	@Test
	void test() {
		GraphInterface g = new DirectedGraph("4;0 1 3;0 2 6;1 2 1;3 0 3");
		Dijkstra stra = new Dijkstra(g);
		assertNotNull(stra);
	}
	@Test
	void distanze() {
		GraphInterface g = new DirectedGraph("3;0 1 3;0 2 6;1 2 1");
		Dijkstra stra = new Dijkstra(g);
		int dist[] = stra.getDistanze(0);
		System.out.println(dist[0]);
		System.out.println(dist[1]);
		System.out.println(dist[2]);
		System.out.println(dist[3]);
		assertEquals(6,dist[2]);
	}
	

}
