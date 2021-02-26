package it.uniupo.labAlgo2;

import static org.junit.Assert.*;

import org.junit.Test;

import it.uniupo.graphLib.DirectedGraph;
import it.uniupo.graphLib.GraphInterface;
import it.uniupo.graphLib.UndirectedGraph;

public class TestDFS {

	@Test
	public void testCreate() {
		GraphInterface grafo = new DirectedGraph(3);
		DFS dfsTest = new DFS(grafo); 
		assertNotNull(dfsTest);
		}
	
	@Test
	public void testScoperti() throws Exception {
		GraphInterface grafo = new DirectedGraph ("3;0 1;1 2");
		DFS dfsTest = new DFS(grafo);
		dfsTest.getTree(0);
	}
	
	@Test
	public void testDAG(){
		GraphInterface grafo = new DirectedGraph ("4;0 2;1 2;1 0;3 1;3 0");
		DFS topOrd = new DFS(grafo);
		topOrd.topologicalOrder();
		assertNotNull(topOrd);
	}
	@Test
	public void testDAG2() {
		GraphInterface grafo = new DirectedGraph ("4;0 2;1 2;1 0;3 1;3 0");
		DFS topOrd = new DFS(grafo);
		topOrd.topologicalOrder();
		assertNotNull(topOrd);
	}
	
	@Test (expected = Exception.class)
	public void testUndir() throws Exception{
		GraphInterface grafo = new UndirectedGraph ("4;0 2;1 2;1 0;3 1;3 0");
		DFS dfsTest = new DFS(grafo);
		dfsTest.getTree(0);
	}
	
	@Test (expected = Exception.class)
	public void testCycleGraph() throws Exception{
		GraphInterface grafo = new DirectedGraph ("4;0 2;1 2;1 0;3 1;3 0;2 0");
		DFS dfsTest = new DFS(grafo);
		dfsTest.getTree(0);
	}
	
}
