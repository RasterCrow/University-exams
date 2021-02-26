package it.uniupo.labAlgo2;

import static org.junit.Assert.*;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.Test;

import it.uniupo.graphLib.DirectedGraph;
import it.uniupo.graphLib.GraphInterface;
import it.uniupo.graphLib.UndirectedGraph;

public class TestPrim {

	@Test
	public void test() {
		UndirectedGraph g = new UndirectedGraph("5;0 1 3;0 2 6;1 2 1;2 3 5;1 4 10;2 4 1");
		Prim prim = new Prim(g);
		System.out.println(prim.getMST(0));
		assertNotNull(prim);
	}

}
